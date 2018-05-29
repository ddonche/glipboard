class ParticipationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_glip, only: [:create]

  def create
    @user = current_user
    Participation.create!(user_id: @user.id, glip_id: @glip.id)
    Notification.create!(glip_id: @glip.id, recipient_id: @glip.user_id, 
                      notified_by_id: current_user.id, notification_type: "participation")
    voltaire_up(2, :reputation, @glip.user_id)
    Glip.create!(parent_id: @glip.id, title: @glip.title, content: @glip.content, 
                  completion_criteria: @glip.completion_criteria, user_id: @user.id)
    respond_to do |format|
      @last = current_user.glips.last
      format.html { redirect_to glip_path(@last.id), notice: "You joined! Don't forget to customize it with your own content, milestones, tags, etc." }
      format.js { redirect_to glip_path(@last.id), notice: "You joined! Don't forget to customize it with your own content, milestones, tags, etc." }
    end
    UserNotifier.send_joinglip_email(@glip.user).deliver_later
  end

  def destroy
    user = current_user
    @glip = Glip.find(params[:participation][:glip_id])
    participation = user.participations.find_by(glip_id: @glip.id)
    @user_glip = user.glips.find_by(parent_id: @glip.id)
    @user_glip.destroy
    participation.destroy
    voltaire_down(2, :reputation, @glip.user_id)
    respond_to do |format|
      format.html { redirect_to glips_path }
      format.js { redirect_to glips_path }
    end
  end
  
  private
  def set_glip
    @glip = Glip.friendly.find(params[:glip_id])
  end
end