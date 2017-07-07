class ResponsesController < ApplicationController
  before_action :set_response, except: [:create]
  before_action :set_post, only: [:new, :create, :edit, :update, :destroy, :upvote, :downvote]
  before_action :set_group, only: [:create, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @responses = @post.responses.order('created_at DESC').page(params[:page]).per(20)
  end

  def new
    @response = @post.responses.new
    respond_to do |format|  
      format.html
      format.js
    end
  end
  
  def create
    @response = @post.responses.new(response_params) 
    @response.user_id = current_user.id if current_user
    if @response.save
      unless @post.user_id == @response.user_id
        Notification.create!(group_id: @group.id, post_id: @post.id, recipient_id: @post.user_id, 
                        response_id: @response.id, notified_by_id: current_user.id, 
                        notification_type: "response")
      end
      redirect_to group_post_path(@group, @post), notice: "Response created."
    else
      render :new
    end
  end
  
  def edit   
    @response = Response.find(params[:id])
    @creator = User.friendly.find(@group.creator_id)
  end
  
  def update
    respond_to do |format|
      if @response.update(response_params)
         format.html { redirect_to group_post_path(@group, @post), notice: 'Response was successfully updated.' }
      else
         format.html { render :edit }
      end
    end
  end

  def destroy
    @response.destroy
    respond_to do |format|
      format.html redirect_to group_post_path(@group, @post), notice: 'response was eradicated.'
    end
  end
  
  def upvote
    if @response.user_id != current_user.id
      @response.upvote_by current_user
      
      voltaire_up(1, :reputation, @response.user_id)
      respond_to do |format|
        format.html { redirect_to group_post_path(@group, @post) }
        format.js
      end
    end
  end
  
  def downvote
    if @response.user_id != current_user.id
      @response.downvote_by current_user
      
      voltaire_down(1, :reputation, @response.user_id)
      respond_to do |format|
        format.html { redirect_to group_post_path(@group, @post) }
        format.js
      end
    end
  end

  private

  def set_response
    @response = Response.find(params[:id])
  end
  
  def set_post
    @post = Post.friendly.find(params[:post_id])
  end
  
  def set_group
    @group = Group.friendly.find(params[:group_id])
  end
  
  def response_params
    params.require(:response).permit(:subtitle, :content, :user_id, :post_id, :youtube)
  end
end