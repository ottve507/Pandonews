class Comment < ActiveRecord::Base
  attr_accessible :ancestry, :commentable_id, :commentable_type, :content, :user_id, :parent_id 
  belongs_to :commentable, :polymorphic => true
  has_ancestry
  make_voteable
end
