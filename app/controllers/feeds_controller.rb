class FeedsController < ApplicationController
  autocomplete :cronfeed, :address
  before_filter :log_impression, :only => [:show]
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  
  include FeedsHelper
  include CommentsMod
  include LanguageDetector
  
  
  
  def log_impression
    @article = Feed.find(params[:id])
    #@article.impressions.create(ip_address: request.remote_ip, user_id:current_user.id)
    @article.impressions.create(ip_address: request.remote_ip)
  end
  
  def index
    @feeds = Feed.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feeds }
    end
  end

  def new
    if current_user.blank?
      redirect_to sessions_path
    elsif current_user.plates.blank? 
      redirect_to new_plate_path
    else
    @language_setting = detectLanguage
    @location_setting = Geocoder.search(request.remote_ip)
    ##@location_setting = Geocoder.search("85.226.139.5")
      
       
    @plates = current_user.plates
    @feed = Feed.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feed }
    end
  end
  end

  def edit   
     if current_user.id != 1
        redirect_to sessions_path
      elsif current_user.plates.blank? 
        redirect_to new_plate_path
      else
      @plates = current_user.plates
      @language_setting = detectLanguage
      @location_setting = Geocoder.search(request.remote_ip)
      ##@location_setting = Geocoder.search("85.226.139.5")
      @feed = Feed.find(params[:id])
    end
    
  end

  def create
    @feed = Feed.new(params[:feed])
    @feed.user_id = current_user.id
    @feed.save
    
    #Feedzira!
    if @feed.type_of_feed !=nil
      @byAddress = Cronfeed.find_by_address(@feed.type_of_feed)
      @byTitle = Cronfeed.find_by_feed_title(@feed.type_of_feed)
      
      if !@byAddress.nil?
        
        @c =  Cronfeedplaterelationship.create(:plate_id => @feed.original_plate_id, :cronfeed_id => @byAddress.id)
        @alreadyAddedFeeds = Feed.where(:type_of_feed => @byAddress.address).last(10)
        @alreadyAddedFeeds.each do |f|
          Platerelationship.create(:feed_id => f.id, :plate_id => @feed.original_plate_id)
        end
        
      elsif !@byTitle.nil? && @feed.url.to_i == @byTitle.id

        @c =  Cronfeedplaterelationship.create(:plate_id => @feed.original_plate_id, :cronfeed_id => @byTitle.id)
        @alreadyAddedFeeds = Feed.where(:type_of_feed => @byTitle.address).last(10)
        @alreadyAddedFeeds.each do |f|
          Platerelationship.create(:feed_id => f.id, :plate_id => @feed.original_plate_id)
        end        
    
      elsif @byAddress.nil? && @byTitle.nil? && Feedzirra::Feed.fetch_and_parse(@feed.type_of_feed) == 0
        #redirect?
      else
        
        @feedsFromAddress = Feedzirra::Feed.fetch_and_parse(@feed.type_of_feed)
        @urlFeedInfo = Domainatrix.parse(@feedsFromAddress.entries[0].id)
        @urlToIcon = @urlFeedInfo.scheme + '://' + @urlFeedInfo.domain + '.' + @urlFeedInfo.public_suffix + '/favicon.ico'                        
        @c = Cronfeed.create(:plate_id => @feed.original_plate_id, :address => @feed.type_of_feed, :user_id =>current_user.id, :feedpic => @urlToIcon, :feed_title => @feedsFromAddress.title)
        @c =  Cronfeedplaterelationship.create(:plate_id => @feed.original_plate_id, :cronfeed_id => @c.id)
        Feed.update_from_feed_new(@feed.type_of_feed, Plate.where(:id =>@feed.original_plate_id), @feedsFromAddress.title, @urlToIcon)                

      end 
          
    end
    
    #tags :P
    if @feed.tag_list.empty? && @feed.url == nil
      @feed.tag_list = @feed.title.split(" ").first(10)
      @feed.save
    end

    respond_to do |format|
      if @feed.save      
        format.html { redirect_to user_path(current_user.id), notice: 'Feed was successfully created.' }
        format.json { render json: @feed, status: :created, location: @feed }
        if @feed.type_of_feed != nil
           @feed.destroy
        else
          @p = Platerelationship.create(:plate_id => @feed.original_plate_id, :feed_id => @feed.id)
        end
      
      else
        format.html { render action: "new" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end   
  end
  
  def add_feed
    if current_user.blank?
       redirect_to sessions_path
     elsif current_user.plates.blank? 
       redirect_to new_plate_path
     else
       @feed = Feed.new
       @plates = current_user.plates
     end
  end

  def update
    @feed = Feed.find(params[:id])
    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_url }
      format.json { head :no_content }
    end
  end
  
  def show
    @cpr = Cronfeedplaterelationship.new
    @feed = Feed.find(params[:id])
    @pr = Platerelationship.new
    @relatedFeeds = Feed.tagged_with(@feed.tag_list, :any => true).tagged_with(["the", "on", "by", "and", "in", "is", "are", "to"], :exclude => true)
    
    if @feed.location?
    #Fetch popular local feeds
    @t = Time.now
    @h1 = @t - 1.hour
    @localfeeds = @feed.nearbys(100)
    if !@localfeeds.nil?
      @localfeeds = @localfeeds.sort_by &:created_at
      @localfeeds = @localfeeds.reverse.first(5)
      @localfeeds = @localfeeds.sort { |p1, p2| p2.impressionist_count(:filter=>:all, :start_date=>@h1) <=> p1.impressionist_count(:filter=>:all, :start_date=>@h1)}
    end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json 
      format.js
     end
  end
  
  def vote
    value = params[:type] == "up" ? 1 : -1
    @feed = Feed.find(params[:id])
    if value == 1
      current_user.up_vote(@feed)
    else
      current_user.down_vote(@feed)
    end
    redirect_to :back, notice: "Thank you for voting"
  end

end
