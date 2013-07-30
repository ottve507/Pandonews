class User < ActiveRecord::Base
  attr_accessible :email, :firstname, :image, :image_small, :language, :lastname, :location, :name, :provider, :uid
  make_voter
  
  #geocoded_by :location
  #after_validation :geocode, :if => :location_changed?
  # has_many :feeds

  has_many :settings     
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :plates
  has_many :userplaterelationships
  has_many :secondaryplates, :through => :userplaterelationships


        def self.from_omniauth(auth)
          find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
        end

        def self.create_with_omniauth(auth)
          create! do |user|
            user.provider = auth["provider"]
            user.uid = auth["uid"]
            user.name = auth["info"]["name"]
            user.email = auth["info"]["email"]
            if user.provider == 'twitter' || 'identity'
              fullname = auth["info"]["name"].split(' ')
              user.firstname, user.lastname = fullname[0], fullname[1]
            else
            user.firstname = auth["info"]["first_name"]
            user.lastname = auth["info"]["last_name"]
            end
            
            setting = Setting.new
            
            if user.provider == "twitter" || user.provider == "facebook"       
            user.image = auth["info"]["image"].sub("_large", "")
            user.image_small = auth["info"]["image"].sub("=large", "")
            user.language = auth["info"]["locale"]
            user.location = auth["info"]["location"]
            setting.primary_language = user.language
            setting.location = user.location       
            end
            
            setting.firstname = user.firstname
            setting.lastname = user.lastname
            setting.email = user.email
            setting.save
            setting.user_id = setting.id
            setting.save
      
          end
        end

        #Method to check if the feeder is connected to the user.
        def is_friend?(friend)
          return self.friends.include? friend
        end
        
        #Method to check if the user has the plate
        def has_plate?(plate)    
          return self.secondaryplates.include? plate
        end
        

        def self.search(search)
          if search
            find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
          else
            find(:all)
          end
        end

      end
