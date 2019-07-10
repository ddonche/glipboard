class Remark < ApplicationRecord
  belongs_to :response
  belongs_to :user
  has_many :notifications, foreign_key: 'remark_id', dependent: :destroy
  acts_as_votable
end