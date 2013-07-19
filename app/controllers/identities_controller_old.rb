class IdentitiesController < ApplicationController
  require 'will_paginate/array'
  def new
    @identity = env['omniauth.identity']
  end
  
  def show
    @user = User.find(params[:id])
    @setting = Setting.find(params[:id])
    @plates = @user.plates
    @secondaryplates = @user.secondaryplates
  
    @friends = User.find(:all)
    
    #For partial_____________________________
    @test = @user.feeds(:all)
    @user.secondaryplates.each do |p|
      if @test2==nil
      @test2 = p.feeds(:all)
      else
      @test2 =@test2 + p.feeds(:all)
      end
    end
    @user.friends.each do |p|
      if @test3==nil
      @test3 = p.feeds(:all)
      else
      @test3 =@test3 + p.feeds(:all)
      end
    end
    
    if @test!=nil
      @testcomplete = @test
    end
    
    if @test2!=nil
      if @testcomplete == nil
       @testcomplete = @test2
      else
       @testcomplete = @testcomplete +@test2
      end
    end
      
    if @test3!=nil
       if @testcomplete == nil
        @testcomplete = @test3
        else
        @testcomplete = @testcomplete +@test3
        end
    end
    
    @test = @testcomplete.sort_by { |obj| obj.created_at }
    @test = @test.reverse
    
    @t = Time.now
    @h1 = @t - 1.hour
    @t = Time.now
    @h1 = @t - 1.hour
    @testcomplete = @test.sort { |p1, p2| p2.impressionist_count(:filter=>:all, :start_date=>@h1) <=> p1.impressionist_count(:filter=>:all, :start_date=>@h1)}
    
   # feed = @user.feeds(:order => "created_at DESC").sort { |p1, p2| p2.impressionist_count(:filter=>:all, :start_date=>@h1) <=> p1.impressionist_count(:filter=>:all, :start_date=>@h1)}
   # @feeds = feed.paginate(:page => params[:page], :per_page => 7)
    @feeds = @testcomplete.paginate(:page => params[:page], :per_page => 7)

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
    
    @test
    @test = params[:hej]
    
  end
  
end
