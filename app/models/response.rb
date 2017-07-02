class Response < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :remarks, dependent: :destroy
  acts_as_votable
end