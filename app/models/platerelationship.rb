class Platerelationship < ActiveRecord::Base
  attr_accessible :feed_id, :plate_id
  belongs_to :plate
  belongs_to :feed
end
