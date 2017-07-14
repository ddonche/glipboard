class Podcast < ApplicationRecord
  belongs_to :user
  has_many :episodes, dependent: :destroy
  
  validates_presence_of :title, :content, :image
  validate :maximum_amount_of_tags
  
  mount_uploader :image, ImageUploader
  
  acts_as_taggable
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
  
  def maximum_amount_of_tags
    number_of_tags = tag_list_cache_on("tags").uniq.length
    errors.add(:base, "Only 5 tags allowed") if number_of_tags > 5
  end
end
