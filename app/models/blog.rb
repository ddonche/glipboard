class Blog < ApplicationRecord
  belongs_to :user, required: true
  has_many :comments, as: :commentable
  
  validates_presence_of :title, :content
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  acts_as_taggable
  acts_as_votable
end
