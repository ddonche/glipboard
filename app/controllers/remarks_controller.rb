class RemarksController < ApplicationController
  before_action :set_response
  before_action :set_post
  before_action :set_group
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @remarks = @response.remarks
  end

  def new
    @remark = @response.remarks.new
  end
  
  def create
    @remark = @response.remarks.new(remark_params) 
    @remark.user_id = current_user.id if current_user
    if @remark.save
      redirect_to :back
    else
      render :new
    end
  end
  
  def edit   
    @remark = Remark.find(params[:id])
  end
  
  def update
    respond_to do |format|
      if @remark.update(remark_params)
         format.html { redirect_to :back }
      else
         format.html { render :edit }
      end
    end
  end

  def destroy
    @remark = Remark.find(params[:id])
    @remark.destroy
    respond_to do |format|
      format.html { redirect_to group_post_path(@group, @post), notice: 'Remark was eradicated.' }
    end
  end
  
  def upvote
    if @remark.user_id != current_user.id
      @remark.upvote_by current_user
      
      voltaire_up(1, :reputation, @remark.user_id)
      redirect_to(:back)
    end
  end
  
  def downvote
    if @remark.user_id != current_user.id
      @remark.downvote_by current_user
      
      voltaire_down(1, :reputation, @remark.user_id)
      redirect_to(:back)
    end
  end

  private
  
  def set_response
    @response = Response.find(params[:response_id])
  end
  
  def set_group
    @group = Group.friendly.find(params[:group_id])
  end
  
  def set_post
    @post = Post.friendly.find(params[:post_id])
  end
  
  def remark_params
    params.require(:remark).permit(:content, :user_id, :response_id)
  end
end