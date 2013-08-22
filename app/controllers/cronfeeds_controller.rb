class CronfeedsController < ApplicationController

  def index
    @cronfeeds = Cronfeed.order(:feed_title).where("feed_title like ?", "%#{params[:term]}%")
    render json: @cronfeeds.map(&:feed_title)
  end
  
end
