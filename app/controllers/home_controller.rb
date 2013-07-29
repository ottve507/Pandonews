class HomeController < ApplicationController 
  
  def index    
    #Shows hottest feeds this hour!    
    @t = Time.now
    @h1 = @t - 1.hour

	@link_feed_type = 'mostread'
  if params[:feed_type] == nil || params[:feed_type] == 'mostread'
    feed = Feed.find(:all, :order => "created_at DESC").sort { |p1, p2| p2.impressionist_count(:filter=>:all, :start_date=>@h1) <=> p1.impressionist_count(:filter=>:all, :start_date=>@h1)}
    @feeds = feed.paginate(:page => params[:page], :per_page => 7)
    @link_feed_type = 'mostread'
  elsif params[:feed_type] == 'mostrecent'
    feed = Feed.find(:all, :order => "created_at DESC")
    @feeds = feed.paginate(:page => params[:page], :per_page => 7)
    @link_feed_type = 'mostrecent'
  elsif params[:feed_type] == 'mostcommented'
    feed = Feed.find(:all, :order => "created_at DESC").sort_by { |feed| feed.comments.count }.reverse
    @feeds = feed.paginate(:page => params[:page], :per_page => 7)
    @link_feed_type = 'mostcommented'
  end
 
  
    @feedsWithLocations = findLocatedFeeds().first(7)

    respond_to do |format|
       format.html 
       format.json
       format.js
     end
 end
 
 private
 def findLocatedFeeds()
   @t = Time.now
   @h1 = @t - 1.hour
   locate = Feed.find(:all, :conditions => "latitude IS NOT NULL",:order => "created_at DESC")
   locate = locate.sort { |p1, p2| p2.impressionist_count(:filter=>:all, :start_date=>@h1) <=> p1.impressionist_count(:filter=>:all, :start_date=>@h1)}
   return locate
 end
 
  
end
