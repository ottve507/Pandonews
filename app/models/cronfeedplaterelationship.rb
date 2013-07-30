class Cronfeedplaterelationship < ActiveRecord::Base
  attr_accessible :cronfeed_id, :plate_id
  
  belongs_to :plate
  belongs_to :cronfeed
end
