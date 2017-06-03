class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  validates :sender, uniqueness: {scope: :receiver}
  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy
  
  scope :participating, -> (user) do
    where("(conversations.sender_id = ? OR conversations.receiver_id = ?)", user.id, user.id)
  end
  
  def with(current_user)
    sender == current_user ? receiver : sender
  end
end
