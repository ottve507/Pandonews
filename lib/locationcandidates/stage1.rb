# encoding: utf-8
class Stage1 < ActiveRecord::Base  
  Dir[File.join("./lib", "**/*.rb")].each {|file| require file}
  
  private
  
  def self.findcandidatesstage1(feed)
    @text = Sanitize.clean(feed.title) + '. ' + Sanitize.clean(feed.content)
    @textdown = @text.downcase
    
    @return = Stage2.findcandidatesstage2(@text,feed)
    
    if @return == nil
      @return = Stage3.findcandidatesstage3(feed)
    end                  
       
    return @return    
  end 
  
end