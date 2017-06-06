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
    @commentable = @post
    @comments = @commentable.comments
    @comment = Comment.new
    @group = Group.friendly.find(params[:group_id])
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

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
      
      voltaire_up(1, :reputation, @post.user_id)
      redirect_to :back
    end
  end
  
  def downvote
    if @post.user != current_user
      @post.downvote_by current_user
      
      voltaire_down(1, :reputation, @post.user_id)
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
      params.require(:post).permit(:title, :content, :user_id, :group_id)
    end
end
