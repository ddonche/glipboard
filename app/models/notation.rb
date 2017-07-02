class Notation < ApplicationRecord
  belongs_to :comment
  belongs_to :user
  acts_as_votable
end