class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  mount_uploader :picture, PictureUploader
  acts_as_voter
  extend FriendlyId
  friendly_id :username, use: :slugged
         
  validates_presence_of :username
  #validates_presence_of :picture
  #validates_integrity_of :picture
  #validates_processing_of :picture

  has_many :glips
  has_many :blogs
  has_many :comments
  has_many :logs
  
  private
    def picture_size_validation
      errors[:picture] << "should be less than 500KB" if picture.size > 0.5.megabytes
    end
end
