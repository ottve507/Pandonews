# encoding: utf-8
class Knownbadwords < ActiveRecord::Base
  
  Dir[File.join("./lib", "**/*.rb")].each {|file| require file}

  def self.loadBadWords(string)
    @return = false
    text=File.open('./lib/assets/badwords.txt').read
    text.gsub!("\n", "\n")
     text.each_line do |line|
       if string == line[0..line.length-2]
         @return = true
         puts "Found invalid name"
         puts line
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         puts "_________________"
         
         
         break
       end    
     end   
  end


end