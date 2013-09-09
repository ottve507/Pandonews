class SettingsController < ApplicationController

def new
@setting = Setting.new
respond_to do |format|
format.html # new.html.erb
format.json { render json: @feed }
end

end

def edit
@setting = Setting.find(params[:id])
@user = User.find(params[:id])

if current_user.id != @user.id
   redirect_to user_path(current_user.id)
end

end

def create
    @setting = Setting.new(params[:setting])
    @setting.user_id = current_user.id
    respond_to do |format|
      if @setting.save
        format.html { redirect_to edit_setting_path(@setting), notice: 'Setting was successfully created.' }
        format.json { render json: edit_setting_path(@setting), status: :created, location: @setting }
      else
        format.html { render action: "new" }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
end

def update
@setting = Setting.find(params[:id])
respond_to do |format|
if @setting.update_attributes(params[:setting])
format.html { redirect_to edit_setting_path(@setting), notice: 'Settings was updated' }
format.json { head :no_content }
else
format.html { render action: "edit" }
format.json { render json: @setting.errors, status: :unprocessable_entity }
end
end
end

def destroy
@setting = Setting.find(params[:id])
@setting.destroy

respond_to do |format|
format.html { redirect_to feeds_url }
format.json { head :no_content }
end
end

def show
@setting = Setting.find(params[:id])
respond_to do |format|
format.html # show.html.erb
format.json { render json: @feed }
end
end

def plate_settings
  @user = User.find(params[:id])
  @setting = Setting.find(params[:id])
  @plates = @user.plates
  @secondaryplates = @user.secondaryplates
  
  if current_user.id != @user.id
     redirect_to user_path(current_user.id)
  end
  
end

end
