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
          text = Sanitize.clean(merge.content) + ' ' + Sanitize.clean(merge.title) + ' ' + text
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
  
  def self.test
      @feeds = Feed.where(:location => nil)
      @feeds.each do |f|
      @c=Stage1.findcandidatesstage1(@feeds)
      end        
  end
  
  
  def self.updatefeedswithlocation
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
  
end
