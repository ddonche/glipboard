class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :glip
  validates :user_id, presence: true
  validates :glip_id, presence: true
end