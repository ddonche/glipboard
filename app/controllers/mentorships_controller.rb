class MentorshipsController < ApplicationController
  def new
    @mentorship = Mentorship.build
  end

  def create
    @mentorship = Mentorship.new(mentorship_params)
    respond_to do |format|
      if @mentorship.save
        voltaire_up(10, :reputation, @mentorship.article.user_id)
        @article = @mentorship.article
        if (@article.standard? && @article.mentorships.count > 15)
          @article.featured!
          voltaire_up(15, :reputation, @article.user_id)
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