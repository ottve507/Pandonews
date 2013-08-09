# encoding: utf-8
class Stage2 < ActiveRecord::Base
  Dir[File.join("./lib", "**/*.rb")].each {|file| require file}
  
  private
  
  def self.findcandidatesstage2(text,feed)
    
    #Get an ok text to analyze
      @arrayText = text.split(' ')
    
    #Fill an initial array with words and initial points depending on capital letters and sentence ending symbols
    #Word, Capitalized?, Points 1 if beginning, 2 if not, 0 if nothing
       @mixedArray = [[],[],[]]
                
      for i in 0..(@arrayText.length-1)      
           if i != 0 && !Charactervalidation.checkCharacters(@arrayText[i-1])
             if @arrayText[i][0] == @arrayText[i][0].capitalize
               @mixedArray[0][i] = @arrayText[i]
               @mixedArray[1][i] = true
               @mixedArray[2][i] = 2
             else
               @mixedArray[0][i] = @arrayText[i]
               @mixedArray[1][i] = false
               @mixedArray[2][i] = 0             
             end        
           else 
             if @arrayText[i][0] == @arrayText[i][0].capitalize
                 @mixedArray[0][i] = @arrayText[i]
                 @mixedArray[1][i] = true
                 @mixedArray[2][i] = 1
               else
                 @mixedArray[0][i] = @arrayText[i]
                 @mixedArray[1][i] = false
                 @mixedArray[2][i] = 0       
             end
           end         
      end
      
      #downcase array
      for i in 0..(@mixedArray[0].length-1)
        @mixedArray[0][i] = @mixedArray[0][i].downcase
      end
      
      #check prepositions
      if feed.language == 'swedish'
       @mixedArray = Prepositions.checkSwedishPrepositions(@mixedArray)
      elsif feed.language == 'english'
       @mixedArray = Prepositions.checkEnglishPrepositions(@mixedArray)
      end
      
      #check repeating capital letters (for example CAPS or headline)
      @mixedArray = Charactervalidation.checkCAPS(@mixedArray)
      
      #check for locations with two-word names
      @mixedArrayMultiple, @mixedArray = Twowordnames.checkTwo(@mixedArray)
      
      #Merge array and sort        
      @mixedArray[0] = @mixedArrayMultiple[0] + @mixedArray[0]
      @mixedArray[1] = @mixedArrayMultiple[1] + @mixedArray[1]
      @mixedArray[2] = @mixedArrayMultiple[2] + @mixedArray[2]
      
      
      @mixedArray = @mixedArray.transpose
      @mixedArray = @mixedArray.sort_by {|e| -e[2]}

      
      
      #Search for top two geocoded locations
      @location = Searchcandidates.searchLocation(@mixedArray)
       
      return @location
  end
  
end