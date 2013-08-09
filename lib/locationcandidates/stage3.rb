# encoding: utf-8
class Stage3 < ActiveRecord::Base
  Dir[File.join("./lib", "**/*.rb")].each {|file| require file}
  
  private
  def self.findcandidatesstage3(feed)
    @cronfeed = feed.plates[0].cronfeeds[0]
    @textAnalyze
    @return = nil
    
    if @cronfeed.location == nil
      @textAnalyze = feed.type_of_feed.downcase
      @goodWords = Searchedword.where(:good => true)
      
      @goodWords.each do |a|
        if (@textAnalyze.include? a.location.downcase) || (@textAnalyze.include? a.altname.downcase)
          @return = a
          @cronfeed.location = a.location
          @cronfeed.save
          break     
        end
      end
      
      if @return == nil
        @return = Stage2.findcandidatesstage2(feed.type_of_feed, feed)
        if @return == nil
          @cronfeed.location = "none"
          @cronfeed.save
        end
                
      end      
      
    elsif @cronfeed.location == "none"
      @return = nil
    else
      @return = Searchedword.find_by_location(@cronfeed.location)        
    end
    
    return @return
        
  end
  
end