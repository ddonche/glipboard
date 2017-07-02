class Remark < ApplicationRecord
  belongs_to :response
  belongs_to :user
  acts_as_votable
end