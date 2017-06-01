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
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  mount_uploader :picture, PictureUploader
  acts_as_voter
  extend FriendlyId
  friendly_id :username, use: :slugged
         
  validates_presence_of :username
  validates_uniqueness_of :username
  
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :glips
  has_many :articles
  has_many :comments
  has_many :created_groups, class_name: "Group"
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :logs, dependent: :destroy

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
  
  #################################################################
  ###### Group Stuff                                          #####
  #################################################################
  
  def join(group)
    membership << group
  end

  # Leaves a group
  def leave(group)
    membership.delete(group)
  end

  # Returns true if the current user is in the group.
  def membership?(group)
    membership.include?(group)
  end
  
  private
    def picture_size_validation
      errors[:picture] << "should be less than 500KB" if picture.size > 0.5.megabytes
    end
end
