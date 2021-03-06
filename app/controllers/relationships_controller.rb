class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    Notification.create!(recipient_id: @user.id, 
                      notified_by_id: current_user.id, notification_type: "follow")
    FollowMailer.new_follower_notification(@user, current_user).deliver_later
    voltaire_up(1, :reputation, @user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    Notification.create!(recipient_id: @user.id, 
                      notified_by_id: current_user.id, notification_type: "unfollow")
    voltaire_down(1, :reputation, @user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
