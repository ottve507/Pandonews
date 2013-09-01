class CronfeedsController < ApplicationController

  def index
    q = "%#{params[:term]}%"
    @cronfeeds = Cronfeed.order(:feed_title).where("feed_title like ? or address like ?", "%#{params[:term]}%", "%#{params[:term]}%")
    #render json: @cronfeeds.map(&:feed_title)
    render json: @cronfeeds.map { |f|
         { feedpic: f.feedpic, feed_title: f.feed_title, value: f.feed_title, id: f.id, address: f.address }
       }
  end
  
end
