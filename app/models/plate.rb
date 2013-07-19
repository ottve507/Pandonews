class Plate < ActiveRecord::Base
  attr_accessible :language, :location, :name, :public, :summmary, :user_id
  belongs_to :User
  has_many :platerelationships
  has_many :userplaterelationships
  has_many :subscribers, :through => :userplaterelationships
  has_many :feeds, :through => :platerelationships
end
