class Notification < ApplicationRecord
  enum notification_type: { comment: 0, notation: 1, message: 2, feature: 3, marked_helpful: 4,
                            participation: 5, response: 6, remark: 7, follow: 8, unfollow: 9 }
  enum read: { read: true, unread: false }
  belongs_to :notified_by, class_name: 'User'
  belongs_to :comment
  belongs_to :notation
  belongs_to :message
  belongs_to :participation
  belongs_to :response
  belongs_to :remark
end