# encoding: utf-8
class Charactervalidation < ActiveRecord::Base
  
  Dir[File.join("./lib", "**/*.rb")].each {|file| require file}
  
  #This method checks if there is a character that perhaps ends a sentence
  def self.checkCharacters(string)
    #Define special characters
    @specialCharacter = "?<>':[]}{=)(*^%$#`~{}!"
    @regex = /[#{@specialCharacter.gsub(/./){|char| "\\#{char}"}}]/
    
    @check = string =~ @regex
    @returnValue = false
    
    if @check != nil 
      @returnValue = true
    end
    
    return @returnValue 
  end
  
  def self.checkInvalidNames(string)
    #Define special characters
    @specialCharacter = "0 1 2 3 4 5 6 7 8 9"
    @returnValue = false 
    @it = string.split(//)   
    
    @it.each do |s|
      if @specialCharacter.include? s
        @returnValue = true
      end
    end
    
    if @it.length < 3
      @returnValue = true
    end
    
    #Method to remove common names and words...
        
    return @returnValue 
  end

  
  #This method checks if there are a lot of words with upper case letters in a sentence.
  def self.checkCAPS(array)
    @countedCAPS=0.0
    @countedNONCAPS=0.0
    
    for i in 0..(array[0].length-1)
      
      if array[1][i]
        @countedCAPS += 1
      else
        @countedNONCAPS+=1
      end
      
      if checkCharacters(array[0][i])          
        if @countedCAPS/(@countedCAPS+@countedNONCAPS) >= 0.5          
          for i in (i-(@countedCAPS-@countedNONCAPS-1.0).to_i)..i
            array[2][i] -= 1
          end                    
        end
        @countedCAPS=0.0
        @countedNONCAPS=0.0            
      end
   
    end    
    return array        
  end
  
end