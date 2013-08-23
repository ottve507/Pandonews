class Cronfeed < ActiveRecord::Base
  attr_accessible :address, :plate_id, :user_id, :feed_title, :feedpic, :language, :location
  has_many :cronfeedplaterelationships
  has_many :plates, :through => :cronfeedplaterelationships
  require_relative '../../lib/locationcandidates/stage1.rb' #from lib/ folder
  
  def self.updatefeedswithcronold
    @allJobs = Cronfeed.all
     @allJobs.each do |c|
      Feed.update_from_feed(c.address, c.user_id, c.plate_id)
     end
  end
  
  def self.updatefeedswithcron
    @allJobs = Cronfeed.all
     @allJobs.each do |c|
      Feed.update_from_feed_new(c.address, c.plates, c.feed_title, c.feedpic)
     end
  end
  
  def self.updatefeedswithlanguage
    @feeds = Feed.where(:language => nil).group(:url_to_feed)
    @feeds.each do |f|
      @feedsWithSpecificFeed = Feed.where(:url_to_feed=>f.url_to_feed)
      @cronWithSpecificFeed = Cronfeed.find_by_address(f.url_to_feed)

      if @cronWithSpecificFeed.language != nil
        
        @feedsWithSpecificFeed.each do |sl|
          sl.language = @cronWithSpecificFeed.language
          sl.save
        end
        
      else
        wl = WhatLanguage.new(:all)
        text = ""
        @feedsWithSpecificFeed.each do |merge|
          content = merge.content ||= merge.summary ||= ""
          text = Sanitize.clean(content) + ' ' + Sanitize.clean(merge.title) + ' ' + text
        end
        
        @lang = wl.language(text)
        
        @feedsWithSpecificFeed.each do |sl|
          sl.language = @lang
          sl.save
        end 
        
        @cronWithSpecificFeed.language = @lang
        @cronWithSpecificFeed.save
             
      end      
    end    
  end
  
  def self.testlocation
      @feeds = Feed.where(:location => nil)
      @feeds.each do |f|
      @c=Stage1.findcandidatesstage1(@feeds)
      end        
  end
  
  
  def self.updatefeedswithlocation_old
        @feeds = Feed.where(:location => nil)
        
        @feeds.each do |f|
          @c = Stage1.findcandidatesstage1(f)
          
          if !@c.nil?
            if !@c.location.nil?
              puts @c.location
              f.location = @c.location
              f.longitude = @c.longitude
              f.latitude = @c.latitude
              f.save
            end
          end
                            
        end                   
  end
  
  #Last step, after this location will be set to "none"
  def self.updatefeedswithlocationfromimage    
    @feedsWI1 = Feed.where("linkobject IS NOT NULL" && "location IS NULL")
    @feedsWI2 = Feed.where("thumbnail_url IS NOT NULL" && "location IS NULL")
    @feedsWI = (@feedsWI1 + @feedsWI2).uniq
    
    @feedsWI.each do |f|
    
      if !f.thumbnail_url.nil? && f.location.nil?
        findImageInfo(f.thumbnail_url, f)
      elsif !f.linkobject.nil? && f.location.nil?
        findImageInfo(f.linkobject, f)
      elsif !f.linkobject.nil? && !f.thumbnail_url.nil? && f.location.nil?
        findImageInfo(f.linkobject, f)
        findImageInfo(f.thumbnail_url, f) if f.location.nil?
      end
      
      if f.location.nil? && f.latitude == nil && f.longitude == nil
        f.location = "0"
        f.save
      end
      
    end
  end
  
  #Run first, otherwise location will be set to none!
  def self.updatefeedswithlocationfromgeotag
    
    @feedsWI = Feed.where("location IS NULL")
    
    @feedsWI.each do |f|   
      if !f.longitude.nil? && !f.latitude.nil?
        @g = Geocoder.search(f.latitude.to_s + ' ,' + f.longitude.to_s)[0]
     
        if !@g.nil?
          f.location = @g.address
          f.save
          puts @g.address
        end
        
        puts '____________________________________'
        puts '____________________________________'
        puts '____________________________________'
        puts '____________________________________'
        puts '____________________________________'
        puts '____________________________________'
        puts '____________________________________'
        puts 'geotag'
        puts f.location
        puts f.longitude
        puts f.latitude
    
        sleep 1              
      end
    end
    
  end
  
  
  def self.findImageInfo(url, feed)
    require 'open-uri'
    
    open('./app/assets/temp/image.jpg', 'wb') do |file|
      file << open(url).read
    end
      pI = MiniExiftool.new './app/assets/temp/image.jpg'
      @location = nil
      
        if !pI.gpslatitude.nil? && !pI.gpslongitude.nil?
          @latitude_unformatted = pI.gpslatitude.split(' ')
          @longitude_unformatted = pI.gpslongitude.split(' ')

          @latitude = (@latitude_unformatted[0]).to_f  + (@latitude_unformatted[2][0..-2]).to_f/60 + (@latitude_unformatted[2][0..-2]).to_f/3600
          @longitude = (@longitude_unformatted[0]).to_f  + (@longitude_unformatted[2][0..-2]).to_f/60 + (@longitude_unformatted[2][0..-2]).to_f/3600

          @gps = (@latitude_unformatted[0] + "."  + @latitude_unformatted[2][0..-2]) + ' ' + (@longitude_unformatted[0] + "."  + @longitude_unformatted[2][0..-2])              
          @g = Geocoder.search(@gps)[0]

          if !@g.nil?
            feed.location = @g.address
            feed.latitude = @g.latitude
            feed.longitude = @g.longitude
            feed.save
            puts @g.address
          end
          
          puts '____________________________________'
          puts '____________________________________'
          puts '____________________________________'
          puts '____________________________________'
          puts '____________________________________'
          puts '____________________________________'
          puts '____________________________________'
          puts 'imagetag'
          puts feed.location
          puts feed.longitude
          puts feed.latitude
          

          sleep 1               
        end

        if @location.nil? && (!pI.city.nil? || !pI.country.nil? || !pI.countryprimarylocationname.nil? || !pI.provincestate.nil?)      
          @city = pI.city || ""
          @state = pI.provincestate || ""
          @country = pI.countryprimarylocationname || pI.country || ""            
          @location = @city + ' ' + @state + ' ' + @country
          puts '_______________________________'
          puts '_______________________________'
          puts '_______________________________'
          puts '_______________________________'
          puts '_______________________________'
          puts '_______________________________'
          puts '_______________________________'
          puts @location
          puts 'HESSSSSJAN'

          @g = Geocoder.search(@location)[0]
          puts @g

          if !@g.nil?
            feed.location = @g.address
            feed.latitude = @g.latitude
            feed.longitude = @g.longitude
            feed.save
            puts @g.address
          end
          
          sleep 1                      
        end
      
      
      File.delete('./app/assets/temp/image.jpg')
    
  end
  
  def self.cleanbug
    f = Feed.where(:location=>0, :latitude => !nil, :longitude => !nil)
    f.each do |p|
      p.location = nil
      p.save
    end
    
  end
    
  
end
