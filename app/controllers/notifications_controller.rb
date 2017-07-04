class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where({ read: false, recipient_id: current_user.id }).order('created_at DESC')
  end
end