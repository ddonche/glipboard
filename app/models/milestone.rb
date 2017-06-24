class Milestone < ApplicationRecord
  belongs_to :glip
  
  def completed?
    !completed_at.blank?
  end
end
