class Blog < ApplicationRecord
  belongs_to :user, required: true
  has_many :comments, as: :commentable
  
  validates_presence_of :title, :body
end
