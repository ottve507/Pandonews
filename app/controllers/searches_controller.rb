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
    search = Search.find(params[:id]).feedresults
    @search = search.paginate(:page => params[:page], :per_page => 7)
    @usersearch = Search.find(params[:id]).userresults
  end
  
end
