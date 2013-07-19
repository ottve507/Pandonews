class UserplaterelationshipsController < ApplicationController
 
   def new
     @upr = Userplaterelationship.new
     respond_to do |format|
       format.html # new.html.erb
       format.json { render json: @upr }
     end
   end

   def create
     @upr = Userplaterelationship.new(params[:userplaterelationship])

     respond_to do |format|
       if @upr.save      
         format.html { redirect_to root_url, notice: 'pr was successfully created.' }
         format.json { render json: root_url, status: :created, location: @upr }    
       else
         format.html { render action: "new" }
         format.json { render json: @upr.errors, status: :unprocessable_entity }
       end
     end   
   end

   def destroy
     @upr = Userplaterelationship.find(params[:id])
     @upr.destroy
     flash[:notice] = "Successfully destroyed friendship."
     redirect_to root_url
   end
  
end
