class Glip < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, as: :commentable
  
  validates_presence_of :title, :content, :completion_criteria
  
  acts_as_taggable
end
