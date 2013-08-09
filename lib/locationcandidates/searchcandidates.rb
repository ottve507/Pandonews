# encoding: utf-8
class Searchcandidates < ActiveRecord::Base
    Dir[File.join("./lib", "**/*.rb")].each {|file| require file}
  
  private
  
  def self.searchLocation(array)    
    @nonApprovedWords = Searchedword.where(:good => false)
    @approvedWords = Searchedword.where(:good => true)
    @nonAString = ''    
    @nonApprovedWords.each do |s|
      @nonAString = @nonAString + ' ' + s.altname
    end
    
    
    array.delete_if do |a|
      
       if (@nonAString.include? a[0]) || Charactervalidation.checkInvalidNames(a[0])
         true
       else
         false
       end    
    end
    
    
 
    if array.length > 1
      @searchField = 1
    else
      @searchField = 0
    end
    
    for i in 0..@searchField 
      
      @approvedWords.each do |a|
        if (array[i][0].include? a.location.downcase) || (array[i][0].include? a.altname.downcase)
          @returnLocation = a 
          break   
        end
      end
      
      if !@returnlocation.nil?
        break
      end
      
      @l=Geocoder.search(array[i][0])[0]
      sleep 1
      @returnLocation = nil
  
      if !@l.nil?
        if @l.display_name.split(',')[0] == @l.city ||  @l.display_name.split(',')[0] == @l.county
          @returnLocation = Searchedword.create(:altname => array[i][0], :longitude => @l.longitude, :latitude=>@l.latitude, :location=>@l.city, :good => true)
          break
        elsif @l.display_name.split(',')[0] == @l.country
          @returnLocation = Searchedword.create(:altname => array[i][0], :longitude => @l.longitude, :latitude=>@l.latitude, :location=>@l.country, :good => true) 
          break
        else
          @returnLocation = Searchedword.create(:altname => array[i][0], :good => false)        
        end
      end
           
    end
        
    return @returnLocation    
        
  end
  
end

