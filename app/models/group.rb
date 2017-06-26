class Group < ApplicationRecord
  after_create :set_membership

  belongs_to :creator, class_name: "User"
  has_many :memberships, dependent:   :destroy
  has_many :users, through: :memberships
  has_many :posts, dependent:   :destroy
  has_many :categories, dependent:   :destroy

  mount_uploader :picture, PictureUploader
  mount_uploader :icon, IconUploader
  mount_uploader :banner, BannerUploader
  
  validates_presence_of :title, :description, :creator_id
  validates_uniqueness_of :title
  validate :maximum_amount_of_tags
  
  scope :imaged, -> {
    where("icon IS NOT NULL")
  }
  
  scope :unimaged, -> {
    where("icon IS NULL")
  }
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
  
  acts_as_taggable
  acts_as_votable
  
  def maximum_amount_of_tags
    number_of_tags = tag_list_cache_on("tags").uniq.length
    errors.add(:base, "Only 5 tags allowed") if number_of_tags > 5
  end
  
  private
  def set_membership
    Membership.create!(user_id: creator_id, group_id: id)
  end
  
  def picture_size_validation
    errors[:picture] << "should be less than 500KB" if picture.size > 0.5.megabytes
  end
end
