class CronfeedplaterelationshipsController < ApplicationController
  
  def create
    @cpr = Cronfeedplaterelationship.new(params[:cronfeedplaterelationship])

    respond_to do |format|
      if @cpr.save      
        format.html { redirect_to root_url, notice: 'pr was successfully created.' }
        format.json { render json: root_url, status: :created, location: @pr }    
      else
        format.html { render action: "new" }
        format.json { render json: @pr.errors, status: :unprocessable_entity }
      end
    end   
  end
  
  def destroy
    @cr = Cronfeedplaterelationship.find(params[:id])
    @cr.destroy
    redirect_to root_url
  end
end
