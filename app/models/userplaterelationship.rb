class Userplaterelationship < ActiveRecord::Base
  attr_accessible :secondaryplate_id, :user_id
  belongs_to :user
  belongs_to :secondaryplate, :class_name => "Plate"
end
