class Blog < ApplicationRecord
  belongs_to :user, required: true
  has_many :comments, as: :commentable
end
