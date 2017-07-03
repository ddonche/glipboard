class Post < ApplicationRecord
  enum sticky: { normal: 0, sticky: 1 }
  enum comments_disabled: { comments_enabled: 0, comments_disabled: 1 }
  
  belongs_to :group
  belongs_to :user
  has_many :responses
  belongs_to :category
  
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
  
  acts_as_votable
end