class Episode < ApplicationRecord
  
  belongs_to :user
  belongs_to :podcast
  has_many :comments, as: :commentable, dependent: :destroy
  
  mount_uploader :image, ImageUploader
  mount_uploader :audio, AudioUploader
  
  validates_presence_of :title, :content, :podcast_id, :audio, :tag_list
  validate :maximum_amount_of_tags
  
  acts_as_taggable
  acts_as_votable
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  delegate :title, to: :podcast, prefix: true
  
  def slug_candidates
    [
      [podcast.title, :title]
    ]
  end
  
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
  
  def maximum_amount_of_tags
    number_of_tags = tag_list_cache_on("tags").uniq.length
    errors.add(:base, "Only 5 tags allowed") if number_of_tags > 5
  end
end
