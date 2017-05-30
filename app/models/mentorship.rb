class Mentorship < ApplicationRecord
  belongs_to :articles, class_name: "Article"
  belongs_to :glips,    class_name: "Glip"
  validates :article_id, presence: true
  validates :glip_id, presence: true
end
