class Glip < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, as: :commentable
  has_many :logs
  
  validates_presence_of :title, :content, :completion_criteria
  validate :maximum_amount_of_tags
  
  acts_as_taggable
  acts_as_votable
  
  def maximum_amount_of_tags
    number_of_tags = tag_list_cache_on("tags").uniq.length
    errors.add(:base, "Only 5 tags allowed") if number_of_tags > 5
  end
end
