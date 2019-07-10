class Response < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :remarks, dependent: :destroy
  has_many :notifications, foreign_key: 'remark_id', dependent: :destroy
  acts_as_votable
end