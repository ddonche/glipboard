class MentorshipsController < ApplicationController
  def new
    @mentorship = Mentorship.build
  end

  def create
    @mentorship = Mentorship.new(mentorship_params)
    respond_to do |format|
      if @mentorship.save
        @article = @mentorship.article
        unless @article.user_id == current_user.id
          Notification.create!(article_id: @mentorship.article.id,
                        glip_id: @mentorship.glip.id,
                        recipient_id: @mentorship.article.user_id, 
                        notified_by_id: current_user.id, 
                        notification_type: "marked_helpful")
          voltaire_up(10, :reputation, @mentorship.article.user_id)
          if (@article.standard? && @article.mentorships.count > 15)
            @article.featured!
            voltaire_up(15, :reputation, @article.user_id)
          end
        end
        format.html { redirect_to article_path(@mentorship.article_id), notice: 'You marked this article as helpful.' }
      else
        format.html { redirect_to article_path(@mentorship.article_id), alert: 'Something went wrong' }
      end
    end
  end

  private
  def set_mentorship
    @mentorship = Mentorship.find(params[:id])
  end

  def mentorship_params
    params.require(:mentorship).permit(:article_id, :glip_id)
  end
end