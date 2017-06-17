class Log < ApplicationRecord
  enum status: { incomplete: 0, complete: 1 }
  belongs_to :user
  belongs_to :glip
  validates :content, presence: true, length: { maximum: 200 }
end
