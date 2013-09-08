class HomeController < ApplicationController 
  
  def index    

	@link_feed_type = 'mostrecent'
  if params[:feed_type] == 'mostread'
    feed = mostviewed_cached
    @link_feed_type = 'mostread'
  elsif params[:feed_type] == nil || params[:feed_type] == 'mostrecent'
    feed = Feed.find(:all, :order => "created_at DESC")
    @link_feed_type = 'mostrecent'
  elsif params[:feed_type] == 'mostcommented'
    feed = Feed.find(:all, :order => "created_at DESC").sort_by { |feed| feed.comments.count }.reverse    
    @link_feed_type = 'mostcommented'
  end
    @feeds = feed.paginate(:page => params[:page], :per_page => 14)
  
    @feedsWithLocations = map_feeds_cached
    
    if !@feeds.nil?
    	@meta = @feeds.first(50)
    	@tokeywords = ' '
    	@meta.each do |m|
    		@tokeywords += m.title + ' '
    	end
    	@tokeywords += 'news parser rss feeds world pulse feedly' 
    end


    respond_to do |format|
       format.html 
       format.json
       format.js
     end
 end
 
 
 private
 def findLocatedFeeds()
   locate = Feed.find(:all, :conditions => "latitude IS NOT NULL and location IS NOT NULL",:order => "created_at DESC").first(7)
   locate.each do |f|
     if remote_file_exists?(f.feedpic) == false
       f.feedpic = "/favicon.ico"
       f.save
     end  
   end
   return locate
 end
 
 def remote_file_exists?(url)
   @return = true
   begin
     Nokogiri::HTML(open(url))
   rescue Exception => e
     @return = false     
   end
   return @return
 end
 
 def mostviewed_cached
   #Shows hottest feeds this hour!    
   readCache = Rails.cache.read('mostviewed')
   if readCache.nil?
     @t = Time.now
     @h1 = @t - 1.hour
     feed = Feed.find(:all, :order => "created_at DESC").sort { |p1, p2| p2.impressionist_count(:filter=>:all, :start_date=>@h1) <=> p1.impressionist_count(:filter=>:all, :start_date=>@h1)}
     Rails.cache.write('mostviewed', feed, :expires_in=> 120.seconds, :raw=>true)
     Rails.cache.write('mostviewed', feed, :expires_in=> 120.seconds, :raw=>true) #bug in rails, needs to be written twice
     return feed
   else    
     return Rails.cache.read('mostviewed')
   end
 end
 
 def map_feeds_cached
   #Shows hottest feeds this hour!    
   readCache = Rails.cache.read('map')
   if readCache.nil?
     feed = findLocatedFeeds()
     Rails.cache.write('map', feed, :expires_in=> 300.seconds, :raw=>true)
     Rails.cache.write('map', feed, :expires_in=> 300.seconds, :raw=>true) #bug in rails, needs to be called twice
     return feed
   else    
     return Rails.cache.read('map')
   end
 end
 
 
 def recent_cached
   Rails.cache.fetch('Category.all') { all }
 end
 
 def mostdiscussed_cached
   Rails.cache.fetch('Category.all') { all }
 end

end
