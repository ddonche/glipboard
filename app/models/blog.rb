class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }

  belongs_to :user, required: true
  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :title, :body
  validate :maximum_amount_of_tags
  
  mount_uploader :image, ImageUploader
  
  acts_as_taggable
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  delegate :username, to: :user, prefix: true
  
  def slug_candidates
    [
      [user.username, :title]
    ]
  end
  
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
  
  def maximum_amount_of_tags
    number_of_tags = tag_list_cache_on("tags").uniq.length
    errors.add(:base, "Only 5 tags allowed") if number_of_tags > 5
  end
  
  private
    def image_size_validation
      errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
    end
end
