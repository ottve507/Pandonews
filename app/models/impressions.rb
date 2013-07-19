class Impressions < ActiveRecord::Base
  attr_accessible :impressionable_id, :impressionable_type, :ip_address, :user_id
end
