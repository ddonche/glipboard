class MilestonesController < ApplicationController
  before_action :set_glip
  before_action :set_milestone, except: [:create]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @milestones = @glip.milestones.order('created_at DESC')
  end
  
  def new
    @milestone = Milestone.new
  end
  
  def create
    @milestone = @glip.milestones.new(milestone_params)
    respond_to do |format|
      if @milestone.save
        format.html { redirect_to :back, notice: 'Your milestone was successfully created.' }
      else
        format.html { redirect_to :back, alert: "Problem with milestone. Maybe too long? Cannot exceed 100 characters." }
      end
    end
  end
  
  def update
  end
  
  def destroy
    @milestone.destroy
    respond_to do |format|
      format.html { redirect_to glip_path(@glip), notice: 'Milestone was successfully deleted.' }
    end
  end
  
  def complete
    @milestone.update_attribute(:completed_at, Time.now)
    @log_content = "Completed a milestone: #{@milestone.content}"
    Log.create!(glip_id: @glip.id, content: @log_content, user_id: current_user.id)
    voltaire_up(1, :reputation, @glip.user_id)
    redirect_to glip_path(@glip)
  end
  
  private
  def set_milestone
    @milestone = Milestone.find(params[:id])
  end
  
  def set_glip
    @glip = Glip.friendly.find(params[:glip_id])
  end

  def milestone_params
    params.permit(:glip_id, :content)
  end
end