class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  belongs_to :user, required: true
  has_many :comments, as: :commentable
  
  validates_presence_of :title, :content
  validate :maximum_amount_of_tags
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  acts_as_taggable
  acts_as_votable
  
  def maximum_amount_of_tags
    number_of_tags = tag_list_cache_on("tags").uniq.length
    errors.add(:base, "Only 5 tags allowed") if number_of_tags > 5
  end
end
