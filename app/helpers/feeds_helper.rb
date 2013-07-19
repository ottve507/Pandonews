module FeedsHelper
  
  def find_profile_pic(id)
     user = User.find_by_id(id)
     user_setting = Setting.find_by_id(id)
     
     url = "boo"

     if user.provider=='facebook' || user.provider=='twitter' 
   		if user_setting.profilepicture.url != '/profilepictures/original/missing.png' 
   			url = setting.profilepicture.url
   		else
   			url = user.image_small
   		end
   	else
   		url = user_setting.profilepicture.url
   	end

   	return url

   end
  
end
