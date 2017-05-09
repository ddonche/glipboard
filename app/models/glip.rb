class Glip < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, as: :commentable
  validates :completion_criteria, :presence => true
  acts_as_taggable
end
