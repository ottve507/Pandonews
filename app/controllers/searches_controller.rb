class SearchesController < ApplicationController

  
  def new
    @search = Search.new
  end
  
  def create
    @search = Search.create!(params[:search])
    redirect_to @search
  end
  
  def show
    @newsearch = Search.new
    @search = Search.find(params[:id]).feedresults
    if @search.nil?
      @search = @search
    else
      @search5 = @search.first(5) 
    end
    @usersearch = Search.find(params[:id]).userresults
    if @usersearch.nil?
      @user5 = @usersearch
    else
      @user5 = @usersearch.first(5)
    end
  end
  
  def show_users
    @newsearch = Search.new
    search = User.find(params[:param].split(/,/))
    @usersearch = search.paginate(:page => params[:page], :per_page => 14)
    respond_to do |format|
       format.html 
       format.json
       format.js
     end
    
  end
  
  def show_feeds
    @newsearch = Search.new
    search = Feed.find(params[:param].split(/,/))
    @search = search.paginate(:page => params[:page], :per_page => 14)
    respond_to do |format|
       format.html 
       format.json
       format.js
     end 
  end
  
end
