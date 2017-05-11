class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]
  
  def index
    @page_title = "Log Entries"
    @glip = Glip.find(params[:glip_id])
    @logs = @glip.logs
  end

  def create
    @glip = Glip.find(params[:glip_id])
    @log = @glip.logs.new(log_params)
    @log.user = current_user

    respond_to do |format|
      if @log.save
        format.html { redirect_to @glip, notice: 'Log was successfully created.' }
      else
        format.html { redirect_to @glip, alert: "There was a problem with your log entry. Maybe it's too long?" }
      end
    end
  end

  def destroy
    @log.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.require(:log).permit(:glip_id, :content, :user_id)
    end
end
