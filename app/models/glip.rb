class Glip < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, as: :commentable
  acts_as_taggable
end
