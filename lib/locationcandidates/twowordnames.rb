# encoding: utf-8
class Twowordnames < ActiveRecord::Base
  Dir[File.join("./lib", "**/*.rb")].each {|file| require file}

  private

  #This method looks for words that might belong together (such as New York or South Korea)  
  def self.checkTwo(array)
    @mixedArray = array
    @removed = 0
    @count = 0
    @newMix = [[],[],[]]
  
    for i in 0..(array[0].length-1)
    
      if array[1][i] && (i == 0 || Charactervalidation.checkCharacters(array[0][i-1])) && array[1][i+1] && !array[1][i+2] && !array[1][i+3] && array[0][i].length > 2
             
        @newMix[0][@count] = array[0][i] + ' ' + array[0][i+1]
        @newMix[1][@count] = array[1][i]
        @newMix[2][@count] = array[2][i] + 1
        @count += 1
      
      
        @mixedArray[0].delete_at(i)
        @mixedArray[1].delete_at(i)
        @mixedArray[2].delete_at(i)
        @mixedArray[0].delete_at(i)
        @mixedArray[1].delete_at(i)
        @mixedArray[2].delete_at(i)
    
      
      elsif !array[1][i-1] && array[1][i] && array[1][i+1] && (!array[1][i+2] || Charactervalidation.checkCharacters(array[0][i+1]))
     
        @newMix[0][@count] = array[0][i] + ' ' + array[0][i+1]
        @newMix[1][@count] = array[1][i]
        @newMix[2][@count] = array[2][i] + 1
        @count += 1
      
      
        @mixedArray[0].delete_at(i)
        @mixedArray[1].delete_at(i)
        @mixedArray[2].delete_at(i)
        @mixedArray[0].delete_at(i)
        @mixedArray[1].delete_at(i)
        @mixedArray[2].delete_at(i)
      
      
      elsif !array[1][i-1] && !array[1][i-2] && array[1][i] && !array[1][i+1] && array[1][i+2] && (!array[1][i+3] || Charactervalidation.checkCharacters(array[0][i+2]))        
      
        @newMix[0][@count] = array[0][i] + ' ' + array[0][i+1] + ' ' + array[0][i+2]
        @newMix[1][@count] = array[1][i]
        @newMix[2][@count] = array[2][i] + 1
        @count += 1
      
        @mixedArray[0].delete_at(i)
        @mixedArray[1].delete_at(i)
        @mixedArray[2].delete_at(i)
        @mixedArray[0].delete_at(i)
        @mixedArray[1].delete_at(i)
        @mixedArray[2].delete_at(i)
        @mixedArray[0].delete_at(i)
        @mixedArray[1].delete_at(i)
        @mixedArray[2].delete_at(i)        
      end
    
    end
       
    return @newMix, @mixedArray
  
  end
end