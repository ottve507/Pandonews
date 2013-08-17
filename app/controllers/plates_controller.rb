class PlatesController < ApplicationController
  include LanguageDetector

    def index
       @plate = Plate.all
       respond_to do |format|
         format.html # index.html.erb
         format.json { render json: @plate}
       end
     end

     def new
       @language_setting = detectLanguage
      ## @location_setting = Geocoder.search(request.remote_ip)
      @location_setting = Geocoder.search("85.226.139.5")
      @plate = Plate.new
       respond_to do |format|
         format.html # new.html.erb
         format.json { render json: @plate }
       end
     end

     def edit       
       @plate = Plate.find(params[:id])
       if current_user.id != @plate.user_id
          redirect_to user_path(current_user.id)
       end        
     end

     def create
       @plate = Plate.new(params[:plate])
       @plate.user_id = current_user.id

       respond_to do |format|
         if @plate.save      
           format.html { redirect_to user_path(current_user.id), notice: 'Plate was successfully created.' }
           format.json { render json: @plate, status: :created, location: @plate}
         else
           format.html { render action: "new" }
           format.json { render json: @plate.errors, status: :unprocessable_entity }
         end
       end   
     end

     def update
       @plate= Plate.find(params[:id])
       respond_to do |format|
         if @plate.update_attributes(params[:plate])
           format.html { redirect_to @plate, notice: 'Plate was successfully updated.' }
           format.json { head :no_content }
         else
           format.html { render action: "edit" }
           format.json { render json: @plate.errors, status: :unprocessable_entity }
         end
       end
     end

     def destroy
       @plate = Plate.find(params[:id])
       @plate.destroy
       @c=Cronfeedplaterelationship.find_by_plate_id(c.id)
       @c.each do |cr|
         cr.destroy
       end

       respond_to do |format|
         format.html { redirect_to plates_url }
         format.json { head :no_content }
       end
     end

     def show
       @plate = Plate.find(params[:id])
       respond_to do |format|
         format.html # show.html.erb
         format.json { render json: @plate }
       end
     end
  
  
end
