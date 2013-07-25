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
     sanitizedString = Sanitize.clean(f.content) + Sanitize.clean(f.title)
     arrayOfWords = sanitizedString.split(' ')
     arrayOfCountries = Array.new
     arrayOfCities = Array.new
     returnLocation = nil
     
     ##Finding locations from word
     if arrayOfWords.count < 30
       arrayOfWords.each do |a|
       searchedLocation = Geocoder.search(a, :lookup => :nominatim)        
            searchedLocation.each do |sl|
              if sl.country == a
                arrayOfCountries.push sl
              elsif sl.city == a
                arrayOfCities.push sl
              end
            end
          sleep 1
       end              
     
       for i in (0..arrayOfWords.count-1)
         if arrayOfWords[i+1] == nil
           break
         end         
         searchedLocation = Geocoder.search(arrayOfWords[i] + ' ' + arrayOfWords[i+1] , :lookup => :nominatim)        
            searchedLocation.each do |sl|
              if sl.country == arrayOfWords[i] + ' ' + arrayOfWords[i+1]
                arrayOfCountries.push sl
              elsif sl.city == arrayOfWords[i] + ' ' + arrayOfWords[i+1]
                arrayOfCities.push sl
              end
            end
          sleep 1
       end              
     
    ##Pairing city and country if possible
      arrayOfCountries.each do |co|
        arrayOfCities.each do |ci|
          if ci.country == co.country
            returnLocation = ci
          end
          end
        end
      end
     end
      
      if returnLocation != nil
        f.location = returnLocation.city
      else
        f.location = "Not specified"
      end
      f.save
       
    end
  end
  
end
