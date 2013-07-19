class Userplaterelationship < ActiveRecord::Base
  attr_accessible :secondaryplate_id, :subscriber_id
  belongs_to :subscriber, :class_name => "User"
  belongs_to :secondaryplate, :class_name => "Plate"
end
