class Log < ApplicationRecord
  belongs_to :user
  belongs_to :glip
  
  validates :content, presence: true, length: { maximum: 200 }
end
