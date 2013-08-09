# encoding: utf-8
class Prepositions < ActiveRecord::Base
  Dir[File.join("./lib", "**/*.rb")].each {|file| require file}
  
  #This method checks if there is a preposition before a certain word
   def self.checkSwedishPrepositions(array)
     @prepositioner = ["från", "i", "inom", "runt", "runtomkring", "utanför" "vid", "igenom", "till", "mellan", "bredvid", "vid", "genom", "före", "för", "mot", "ur", "åt", "framför", "enligt", "efter", "med", "nära"]

     for i in 0..(array[0].length-1)
       if i != 0 && (@prepositioner.include? array[0][i-1])
         array[2][i] += 3
       end
     end
     return array    
   end

   #This method checks if there is a preposition before a certain word
   def self.checkEnglishPrepositions(array)
     @prepositioner = ["beyond", "about", "across", "after", "around", "at", "in", "by", "for", "of", "before", "behind", "beneath", "beside", "by", "down", "from", "inside", "into", "like", "near", "next", "of", "on", "off", "onto", "out", "outside", "over", "past", "round", "through", "throughout", "to", "toward", "under", "underneath", "up", "within", "with"]

     for i in 0..(array[0].length-1)
       if i != 0 && (@prepositioner.include? array[0][i-1])
         array[2][i] += 3
       end
     end
     return array    
   end
  
end