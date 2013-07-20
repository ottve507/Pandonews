class Suggestion < ActiveRecord::Base
  attr_accessible :content, :title
  has_many :comments, :as => :commentable, :dependent => :destroy
end
