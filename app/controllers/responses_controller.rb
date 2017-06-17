class ResponsesController < ApplicationController
  before_action :set_response, except: [:create]
  before_action :set_post, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_group, only: [:create, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @responses = @post.responses.order('created_at DESC').page(params[:page]).per(20)
  end

  def new
    @response = @post.responses.new
  end
  
  def create
    @response = @post.responses.new(response_params) 
    @response.user_id = current_user.id if current_user
    if @response.save
      redirect_to group_post_path(@group, @post), notice: "Response created."
    else
      render :new
    end
  end
  
  def edit   
    @response = Response.find(params[:id])
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
      redirect_to group_post_path(@group, @post), notice: 'response was eradicated.'
    end
  end
  
  def upvote
    if @response.user_id != current_user.id
      @response.upvote_by current_user
      
      voltaire_up(1, :reputation, @response.user_id)
      redirect_to(:back)
    end
  end
  
  def downvote
    if @response.user_id != current_user.id
      @response.downvote_by current_user
      
      voltaire_down(1, :reputation, @response.user_id)
      redirect_to(:back)
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
    params.require(:response).permit(:content, :user_id, :post_id)
  end
end