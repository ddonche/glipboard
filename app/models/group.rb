class Group < ApplicationRecord
  after_create :set_membership
  
  belongs_to :creator, class_name: "User"
  has_many :memberships
  has_many :users, through: :memberships
  
  validates_presence_of :name, :description, :user_id
  validate :maximum_amount_of_tags
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
  
  acts_as_taggable
  acts_as_votable
  
  def maximum_amount_of_tags
    number_of_tags = tag_list_cache_on("tags").uniq.length
    errors.add(:base, "Only 5 tags allowed") if number_of_tags > 5
  end
  
  private
  def set_membership
    Membership.create!(user_id: user_id, group_id: id)
  end
end
