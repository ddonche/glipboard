class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @page_title = "Blogs"
    if params[:tag]
      @blogs = Blog.tagged_with(params[:tag])
    else
      @blogs = Blog.order('created_at DESC').page(params[:page]).per(3)
    end
  end

  def show
    @page_title = @blog.title
    @commentable = @blog
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @blog = current_user.blogs.build
  end

  def edit
  end

  def create
    @blog = current_user.blogs.build(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog post was a success!' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog post was eradicated.' }
      format.json { head :no_content }
    end
  end
  
  def upvote
    @blog.upvote_by current_user
    
    #update user reputation in the database
    5.times.collect do 
      User.increment_counter(:reputation, @blog.user_id)
    end
    redirect_to :back
  end
  
  def downvote
    @blog.downvote_by current_user

    #update user reputation in the database
    5.times.collect do 
      User.decrement_counter(:reputation, @blog.user_id)
    end
    redirect_to :back
  end

  private
    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :content, :user_id, :tag_list)
    end
end
