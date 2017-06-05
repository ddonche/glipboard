class Mentorship < ApplicationRecord
  belongs_to :article
  belongs_to :glip
  validates_presence_of :article_id, :glip_id
end
