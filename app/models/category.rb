class Category < ApplicationRecord
  belongs_to :group
  has_many :posts
  
  mount_uploader :icon, PictureUploader
  
  extend FriendlyId
    friendly_id :slug_candidates, use: :slugged
    delegate :title, to: :group, prefix: true
    
    def slug_candidates
      [
        [group.title, :title]
      ]
    end
    
    def should_generate_new_friendly_id?
      slug.blank? || title_changed?
    end
end