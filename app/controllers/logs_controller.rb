class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @page_title = "Log Entries"
    @glip = Glip.friendly.find(params[:glip_id])
    @logs = @glip.logs.order('created_at DESC').page(params[:page]).per(20)
    @user = @glip.user
    @glips = @user.glips.order("created_at DESC").page(params[:page]).per(10)
    @log = Log.new
  end
  
  def new
    @log = Log.new
  end

  def create
    @glip = Glip.friendly.find(params[:glip_id])
    @log = @glip.logs.new(log_params)
    @log.user = current_user

    respond_to do |format|
      if @log.save
        format.html { redirect_to :back, notice: 'Log was successfully created.' }
      else
        format.html { redirect_to :back, alert: "There was a problem with your log entry. Maybe it's too long? Logs cannot exceed 200 characters." }
      end
    end
  end

  def destroy
    @log.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Log entry was successfully deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.permit(:glip_id, :user_id, :content)
    end
end
