class Membership < ApplicationRecord
  enum role: { member: 0, paid: 1, admin: 2 }

  belongs_to :user
  belongs_to :group
  validates :user_id, presence: true
  validates :group_id, presence: true
end