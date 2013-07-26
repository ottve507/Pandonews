class Cronfeed < ActiveRecord::Base
  attr_accessible :address, :plate_id, :user_id
  
  def self.updatefeedswithcron
    @allJobs = Cronfeed.all
     @allJobs.each do |c|
      Feed.update_from_feed(c.address, c.user_id, c.plate_id)
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
