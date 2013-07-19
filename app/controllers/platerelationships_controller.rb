class PlaterelationshipsController < ApplicationController
 
 def index
    @pr = Platerelationship.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pr }
    end
  end

  def new
    @pr = Platerelationship.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pr }
    end
  end

  def create
    @pr = Platerelationship.new(params[:platerelationship])

    respond_to do |format|
      if @pr.save      
        format.html { redirect_to root_url, notice: 'pr was successfully created.' }
        format.json { render json: root_url, status: :created, location: @pr }    
      else
        format.html { render action: "new" }
        format.json { render json: @pr.errors, status: :unprocessable_entity }
      end
    end   
  end
  
  def destroy
    @pr = Platerelationship.find(params[:id])
    @pr.destroy
    flash[:notice] = "Successfully destroyed friendship."
    redirect_to root_url
  end
  
  
end
