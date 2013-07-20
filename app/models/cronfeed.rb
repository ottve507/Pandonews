class Cronfeed < ActiveRecord::Base
  attr_accessible :address, :plate_id, :user_id
  
  def self.updatefeedswithcron
    @allJobs = Cronfeed.all
     @allJobs.each do |c|
      Feed.update_from_feed(c.address, c.user_id, c.plate_id)
     end
  end
  
end
