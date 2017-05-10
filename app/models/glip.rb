class Glip < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, as: :commentable
  has_many :logs
  
  validates_presence_of :title, :content, :completion_criteria
  
  acts_as_taggable
  acts_as_votable
end
