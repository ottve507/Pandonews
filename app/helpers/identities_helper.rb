module IdentitiesHelper
  
  def ifAllChecked(allsecplates,params)
  x = false
  (0..allsecplates.size-1).each do |i|
    x = params.include? allsecplates[i]
    if x == true
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
    
    ##clear multiple entries of same feed
    if @return
    @return = @return.uniq
    end
      
    return @return
  end
  
  def getFeedz(plates,secondaryplates,myp,sp,sortingmethod,location_setting,startup)
      
    if startup == 1 
      
      ## find all feeds
      if plates!=nil
        (0..plates.size-1).each do |i|
         if !@collectedfeeds
          @collectedfeeds = Plate.find(plates[i]).feeds
         else
          @collectedfeeds =  @collectedfeeds + Plate.find(plates[i]).feeds
         end 
        end
      end

      if secondaryplates !=nil
        (0..secondaryplates.size-1).each do |i|
          if !@collectedfeeds
           @collectedfeeds = Plate.find(secondaryplates[i]).feeds
          else
           @collectedfeeds = @collectedfeeds + Plate.find(secondaryplates[i]).feeds
          end 
        end
      end
      
      
        @collectedfeeds = @collectedfeeds.sort_by(&:created_at).reverse if @collectedfeeds != nil
          
    else
  
      ## find all feeds
      if myp!=nil
        (0..myp.size-1).each do |i|
         if !@collectedfeeds
          @collectedfeeds = Plate.find(myp[i]).feeds
         else
          @collectedfeeds =  @collectedfeeds + Plate.find(myp[i]).feeds
         end 
        end
      end

      if sp !=nil
        (0..sp.size-1).each do |i|
          if !@collectedfeeds
           @collectedfeeds = Plate.find(sp[i]).feeds
          else
           @collectedfeeds = @collectedfeeds + Plate.find(sp[i]).feeds
          end 
        end
      end
      
      if location_setting != nil && @collectedfeeds != nil
        @collectedfeedsmodified = Array.new
        @collectedfeeds.each do |i|
          if i.geocoded?   
            if i.distance_to(location_setting[0].coordinates) < 20
              @collectedfeedsmodified.push i
            end
          end
        end
        @collectedfeeds = @collectedfeedsmodified
      end
      
      if sortingmethod == 'mostviewed'
        @t = Time.now
        @h1 = @t - 1.hour
        @collectedfeeds = @collectedfeeds.sort_by(&:created_at).reverse if @collectedfeeds != nil
        @collectedfeeds = @collectedfeeds.sort { |p1, p2| p2.impressionist_count(:filter=>:created_at, :start_date=>@h1)   <=> p1.impressionist_count(:filter=>:created_at, :start_date=>@h1) } if @collectedfeeds != nil
      elsif sortingmethod == 'mostdisc'
        #@collectedfeeds.sort_by { |f| f.comments.count }
       @collectedmodified = @collectedfeeds.reject{|x| x.created_at < 1.day.ago}.collect{|x| x} if @collectedfeeds != nil
       if @collectedmodified
          @collectedfeeds = @collectedmodified.sort { |p1, p2| p2.comments.count <=> p1.comments.count }
       end
      else
        @collectedfeeds = @collectedfeeds.sort_by(&:created_at).reverse if @collectedfeeds!=nil
      end
          
    end
    
    ##clear multiple entries of same feed
    if @collectedfeeds
      @collectedfeeds = @collectedfeeds.uniq
    end
    
   return @collectedfeeds
  end
  
  def getFeedsForPlate(feeds,sortingmethod,location_setting,startup)
      
    if startup == 1 
      @collectedfeeds = feeds 
      @collectedfeeds = @collectedfeeds.sort_by(&:created_at).reverse if @collectedfeeds != nil       
    else
  
      ## find all feeds
      @collectedfeeds = feeds 
      
      if location_setting != nil && @collectedfeeds != nil
        @collectedfeedsmodified = Array.new
        @collectedfeeds.each do |i|
          if i.geocoded?   
            if i.distance_to(location_setting[0].coordinates) < 20
              @collectedfeedsmodified.push i
            end
          end
        end
        @collectedfeeds = @collectedfeedsmodified
      end
      
      if sortingmethod == 'mostviewed'
        @t = Time.now
        @h1 = @t - 1.hour
        @collectedfeeds = @collectedfeeds.sort_by(&:created_at).reverse if @collectedfeeds != nil
        @collectedfeeds = @collectedfeeds.sort { |p1, p2| p2.impressionist_count(:filter=>:created_at, :start_date=>@h1)   <=> p1.impressionist_count(:filter=>:created_at, :start_date=>@h1) } if @collectedfeeds != nil
      elsif sortingmethod == 'mostdisc'
       @collectedmodified = @collectedfeeds.reject{|x| x.created_at < 1.day.ago}.collect{|x| x} if @collectedfeeds != nil
       if @collectedmodified
          @collectedfeeds = @collectedmodified.sort { |p1, p2| p2.comments.count <=> p1.comments.count }
       end
      else
        @collectedfeeds = @collectedfeeds.sort_by(&:created_at).reverse if @collectedfeeds!=nil
      end
          
    end
    
    ##clear multiple entries of same feed
    if @collectedfeeds
      @collectedfeeds = @collectedfeeds.uniq
    end
    
   return @collectedfeeds
  end
  
end
