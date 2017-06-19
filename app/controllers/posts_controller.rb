class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :set_group, only: [:new, :create, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.order('created_at DESC').page(params[:page]).per(20)
  end

  def show
    @page_title = @post.title
    @user = @post.user
    @responses = @post.responses
    @response = Response.new
    @group = Group.friendly.find(params[:group_id])
    @category = @post.category
    @creator = User.friendly.find(@group.creator_id)
  end

  def new
    @creator = User.friendly.find(@group.creator_id)
    @post = @group.posts.new
    respond_to do |format|  
      format.html
      format.js
    end
  end

  def edit
    @creator = User.friendly.find(@group.creator_id)
    respond_to do |format| 
      format.html
      format.js
    end
  end

  def create
    @post = @group.posts.new(post_params)
    @post.user_id = current_user.id if current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to group_post_path(@group, @post), notice: 'Your post was successful.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to group_post_path(@group, @post), notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was eradicated.' }
    end
  end
  
  def upvote
    if @post.user != current_user
      @post.upvote_by current_user
      
      voltaire_plus(1, :reputation, @post.user_id)
      redirect_to :back
    end
  end
  
  def downvote
    if @post.user != current_user
      @post.downvote_by current_user
      
      voltaire_minus(1, :reputation, @post.user_id)
      redirect_to :back
    end
  end

  private
    def set_post
      @post = Post.friendly.find(params[:id])
    end
    
    def set_group
      @group = Group.friendly.find(params[:group_id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :category_id, :user_id, :group_id)
    end
end
