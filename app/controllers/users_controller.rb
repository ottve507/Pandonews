class UsersController < ApplicationController
  
  def destroy
    @user = User.find(params[:id])
    @plates = @user.plates
    @comments = @user.comments
    
    @comments.each do |c|
      c.destroy
    end
    
    @plates.each do |p|
      @c=Cronfeedplaterelationship.where(:plate_id=>p.id)
      @c.each do |cr|
        cr.destroy
      end
      p.destroy      
    end
    
    @identity = Identity.find_by_email(@user.email)
    @identity.destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to logout_path }
      format.json { head :no_content }
    end
  end
  
end
