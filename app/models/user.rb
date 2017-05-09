class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :picture, PictureUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates_presence_of :username
  validates_presence_of :picture
  validates_integrity_of :picture
  validates_processing_of :picture

  has_many :glips
  has_many :blogs
  has_many :comments
  
  private
    def picture_size_validation
      errors[:picture] << "should be less than 500KB" if picture.size > 0.5.megabytes
    end
end
