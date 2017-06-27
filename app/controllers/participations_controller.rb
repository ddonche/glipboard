class ParticipationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_glip, only: [:create]

  def create
    @user = current_user
    Participation.create!(user_id: @user.id, glip_id: @glip.id)
    voltaire_up(2, :reputation, @glip.user_id)
    respond_to do |format|
      format.html { redirect_to @glip }
      format.js
    end
  end

  def destroy
    user = current_user
    @glip = Glip.find(params[:participation][:glip_id])
    participation = user.participations.find_by(glip_id: @glip.id)
    participation.destroy
    voltaire_down(2, :reputation, @glip.user_id)
    respond_to do |format|
      format.html { redirect_to glips_path }
      format.js
    end
  end
  
  private
  def set_glip
    @glip = Glip.friendly.find(params[:glip_id])
  end
end