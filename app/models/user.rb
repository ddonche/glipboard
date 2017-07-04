class User < ApplicationRecord
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:admin, :editor], multiple: false)                                      ##
  ############################################################################################ 
 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  scope :confirmed, -> { where("confirmed_at IS NOT NULL") }

  mount_uploader :picture, PictureUploader
  mount_uploader :thumbnail, PictureUploader

  acts_as_voter
  extend FriendlyId
  friendly_id :username, use: :slugged
         
  validates :username, presence: true, length: { minimum: 4, maximum: 16 } 
  validates_uniqueness_of :username
  validates_presence_of :birthdate
  
  
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :sent_conversations, class_name: 'Conversation', foreign_key: 'sender_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
  has_many :messages, dependent: :destroy
  has_many :glips, dependent:   :destroy
  has_many :articles, dependent:   :destroy
  has_many :posts, dependent:   :destroy
  has_many :comments, dependent:   :destroy
  has_many :notations, dependent:   :destroy
  has_many :remarks, dependent:   :destroy
  has_many :created_groups, class_name: "Group"
  has_many :memberships, dependent:   :destroy
  has_many :groups, through: :memberships
  has_many :logs, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :participant_glips, through: :participations, :source => :glip

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
  
  ##########GROUP STUFF

  # Returns true if the current user is a member of the group.
  def memberships?(group)
    memberships.include?(group)
  end
  
  private
    def picture_size_validation
      errors[:picture] << "should be less than 500KB" if picture.size > 0.5.megabytes
    end
end