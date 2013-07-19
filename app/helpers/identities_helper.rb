module IdentitiesHelper
  
  def ifAllChecked(allsecplates,params)
  x = false
  (0..allsecplates.size-1).each do |i|
    x = params.include? allsecplates[i]
    if x == false
      break
    end  
  end
  
  return x
  end
  
  def getFeedsStartup(platesid,secplatesid)
    
      ## find all feeds
      if platesid !=nil
      (0..platesid.size-1).each do |i|
         if !@return
           @return = Plate.find(platesid[i]).feeds
         else
           @return = @return + Plate.find(platesid[i]).feeds
         end 
        end
      end

      if secplatesid !=nil
      (0..secplatesid.size-1).each do |i|
          if !@return
           @return = Plate.find(secplatesid[i]).feeds
         else
           @return = @return + Plate.find(secplatesid[i]).feeds
         end 
        end
      end
    
    return @return
    
  end


  def getFeeds(platesid,secplatesid,friendsid)

    ## find all feeds
    if platesid !=nil
    (0..platesid.size-1).each do |i|
       if !@return
         @return = Plate.find(platesid[i].to_i).feeds
       else
         @return = @return + Plate.find(platesid[i].to_i).feeds
       end 
      end
    end
    
    if secplatesid !=nil
    (0..secplatesid.size-1).each do |i|
        if !@return
         @return = Plate.find(secplatesid[i].to_i).feeds
       else
         @return = @return + Plate.find(secplatesid[i].to_i).feeds
       end 
      end
    end
    
    if friendsid !=nil
    (0..friendsid.size-1).each do |i|
        if !@return
         @return = User.find(friendsid[i].to_i).feeds
       else
         @return = @return + User.find(friendsid[i].to_i).feeds
       end 
      end
    end
    
    ##clear multiple entries of same feed
    if @return
    @return = @return.uniq
    end
      
    return @return
  end
  
end
