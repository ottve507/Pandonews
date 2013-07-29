class IdentitiesController < ApplicationController
  require 'will_paginate/array'
  include IdentitiesHelper
  
  def new
    if current_user.blank?
    @identity = env['omniauth.identity']
    else
      redirect_to root_url
    end
  end
  
  def show
    @user = User.find(params[:id])
    @setting = Setting.find(params[:id])
    @plates = @user.plates
    @secondaryplates = @user.secondaryplates  
    
    
    #INFO from and to PARTIAL__________
    if params[:plates]!=nil
     @myp = params[:plates]
     else
     @myp = []
    end
    
    if params[:secondaryplates]!=nil
     @sp = params[:secondaryplates]
    else
     #@sp = @secondaryplates.collect(&:id)
     @sp = []
    end
    
    if params[:sortingmethod]=='mostdisc' || params[:sortingmethod] == 'mostviewed'
      @sortingmethod = params[:sortingmethod]
    else
      @sortingmethod = 'mostrecent'
    end
    
    if params[:sortnearme]!=nil
      #@location_setting = Geocoder.search(request.remote_ip)
      @location_setting = Geocoder.search("85.226.139.5")
    else
      @location_setting = nil
    end
  

    if params[:commit] == 'update'
     @startup = 0
     @allfeeds = getFeeds(@myp,@sp,@f)
    else
     @startup = 1
     @allfeeds = getFeedsStartup(@plates.collect(&:id),@secondaryplates.collect(&:id))
    end
    
    @allfeedz = getFeedz(@plates.collect(&:id),@secondaryplates.collect(&:id),@myp,@sp,@sortingmethod,@location_setting,@startup)

    if @allfeeds
     @feeds = @allfeeds.sort_by &:created_at
     @feeds = @allfeeds.reverse
    end

    @t = Time.now
    @h1 = @t - 1.hour

    @allfeeds = @feeds
    @allfeeds = @allfeedz
    
    if @allfeeds
    @feeds = @allfeeds.paginate(:page => params[:page], :per_page => 7)
    end
    #____________
    
    
    
   
    
    #@feeds = @allfeeds.sort_by { |obj| obj.published_at } sorted = @records.sort_by &:created_at
    #@allfeeds = @feeds.sort { |p1, p2| p2.impressionist_count(:filter=>:all, :start_date=>@t) <=> p1.impressionist_count(:filter=>:all, :start_date=>@h1)}
    # feed = @user.feeds(:order => "created_at DESC").sort { |p1, p2| p2.impressionist_count(:filter=>:all, :start_date=>@h1) <=> p1.impressionist_count(:filter=>:all, :start_date=>@h1)}

    respond_to do |format|
       format.html 
       format.json
       format.js
     end
  end
  
  def showplate    
    @upr = Userplaterelationship.new
    @plate = Plate.find(params[:id])
    @platerelationship = Platerelationship.find_by_plate_id(@plate.id)
    @feeds = @plate.feeds   
    @user = User.find(@plate.user_id)
    @setting = Setting.find(@plate.user_id)
    
    if params[:sortingmethod]=='mostdisc' || params[:sortingmethod] == 'mostviewed'
      @sortingmethod = params[:sortingmethod]
    else
      @sortingmethod = 'mostrecent'
    end
    
    if params[:sortnearme]!=nil
      #@location_setting = Geocoder.search(request.remote_ip)
      @location_setting = Geocoder.search("85.226.139.5")
    else
      @location_setting = nil
    end
    
    if params[:commit] == 'update'
     @startup = 0
    else
     @startup = 1
    end
    
    @feeds = getFeedsForPlate(@feeds,@sortingmethod,@location_setting,@startup)
    @feeds = @feeds.paginate(:page => params[:page], :per_page => 7) 
       
  end
  
end
