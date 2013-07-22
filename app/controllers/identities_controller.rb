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
    @friends = User.find(:all)
    
    #PARTIAL__________
    if params[:plates]!=nil
     @myp = params[:plates]
     else
     @myp = Array.new
    end
    if params[:secondaryplates]!=nil
     @sp = params[:secondaryplates]
    else
     @sp = Array.new
    end
    if params[:friends]!=nil
     @f = params[:friends]
    else
     @f = Array.new
    end

    if params[:commit] == 'update'
     @startup = 0
     @allfeeds = getFeeds(@myp,@sp,@f)
    else
     @startup = 1
     @allfeeds = getFeedsStartup(@plates.collect(&:id),@secondaryplates.collect(&:id))
    end


    if @allfeeds
     @feeds = @allfeeds.sort_by &:created_at
     @feeds = @allfeeds.reverse
    end

    @t = Time.now
    @h1 = @t - 1.hour

    @allfeeds = @feeds

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
    @feeds = @feeds.paginate(:page => params[:page], :per_page => 7)    
  end
  
end
