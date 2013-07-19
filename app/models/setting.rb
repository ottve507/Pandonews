class Setting < ActiveRecord::Base
  attr_accessible :profilepicture, :email, :firstname, :image_choice, :languages, :languages_choice, :lastname, :location, :location_choice, :primary_language, :primary_language_choice, :show_rating, :user_id, :username
  has_attached_file :profilepicture
  
  belongs_to :User

   before_save :destroy_image?

    def image_choice
      @image_choice ||= "0"
    end

    def image_choice=(value)
      @image_choice = value
    end

  private
    def destroy_image?
      self.profilepicture.clear if @image_choice == "1"
    end

end
