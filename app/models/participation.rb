class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :glip
  has_many :notifications, foreign_key: 'participation_id', dependent: :destroy
  validates :user_id, presence: true
  validates :glip_id, presence: true
end