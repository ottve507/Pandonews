class CronfeedplaterelationshipsController < ApplicationController
  
  def destroy
    @cr = Cronfeedplaterelationship.find(params[:id])
    @cr.destroy
    redirect_to root_url
  end
end
