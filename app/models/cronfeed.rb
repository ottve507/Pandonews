class Cronfeed < ActiveRecord::Base
  attr_accessible :address, :plate_id, :user_id, :feed_title, :feedpic, :language, :location
  has_many :cronfeedplaterelationships
  has_many :plates, :through => :cronfeedplaterelationships
  
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
  
  
  def self.updatefeedswithlocation
     @feeds = Feed.where(:location => nil)
     @feeds.each do |f|
        @plate = Plate.find(f.original_plate_id)
        searchedLocation = Geocoder.search(@plate.location, :lookup => :nominatim) 
        f.location = @plate.location
        f.latitude = searchedLocation[0].latitude
        f.longitude = searchedLocation[0].longitude
        f.save
        sleep 1
     end           
  end
end
