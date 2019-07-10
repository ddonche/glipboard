class Notation < ApplicationRecord
  belongs_to :comment
  belongs_to :user
  has_many :notifications, foreign_key: 'notation_id', dependent: :destroy
  acts_as_votable
end