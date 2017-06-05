class Glip < ApplicationRecord
  enum status: { incomplete: 0, complete: 1 }
  enum verified: { unverified: 0, verified: 1 }
  
  belongs_to :user, optional: true
  has_many :comments, as: :commentable
  has_many :articles, through: :mentorships
  has_many :logs
  has_many :mentorships

  validates_presence_of :title, :content, :completion_criteria
  validate :maximum_amount_of_tags
  
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
  
  acts_as_taggable
  acts_as_votable
  
  def maximum_amount_of_tags
    number_of_tags = tag_list_cache_on("tags").uniq.length
    errors.add(:base, "Only 5 tags allowed") if number_of_tags > 5
  end
  
 # Helped by an article
  def help(article)
    helped << article
  end
  
  # Unhelped
  def unhelp(article)
    helped.delete(article)
  end

  # Returns true if the current user is following the other user.
  def helped?(article)
    helped.include?(article)
  end
end
