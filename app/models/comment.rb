class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true 
  belongs_to :user, optional: true
  
  acts_as_votable
end
