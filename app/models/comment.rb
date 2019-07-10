class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true 
  belongs_to :user, optional: true
  has_many :notations, dependent: :destroy
  has_many :notifications, foreign_key: 'comment_id', dependent: :destroy

  acts_as_votable
end
