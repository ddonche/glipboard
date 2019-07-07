class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :toggle_status]
  before_action :authenticate_user!, except: [:index, :show, :featured]
  access all: [:show, :index], 
                user: {except: [:new, :create, :update, :edit, :destroy, :toggle_status]}, admin: :all
  
  def index
    @page_title = "Blogs"
    if params[:tag]
      @blogs = Blog.where({ status: "published" }).tagged_with(params[:tag])
    else
      @blogs = Blog.where({ status: "published" }).order('created_at DESC').page(params[:page]).per(20)
    end
  end
  
  def drafts
    @page_title = "Your Drafts"
    @user = current_user
    @blogs = @user.blogs.where({ status: "draft" }).order("updated_at DESC").page(params[:page]).per(20)
  end

  def show
    @page_title = @blog.title
    @user = @blog.user
    @commentable = @blog
    @comments = @commentable.comments.order("created_at DESC")
    @comment = Comment.new
  end

  def new
    @blog = current_user.blogs.build
    respond_to do |format| 
      format.html
      format.js
    end
  end

  def edit
    @user = @blog.user
    @commentable = @blog
    @comments = @commentable.comments
    @comment = Comment.new
    respond_to do |format|   
      format.html
      format.js
    end
  end

  def create
    @blog = current_user.blogs.build(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_path(@blog), notice: 'Blog was a success!' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @user = @blog.user
    @commentable = @blog
    @comments = @commentable.comments
    @comment = Comment.new
    if current_user == @blog.user
      respond_to do |format|
        if @blog.update(blog_params)
          format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was obliterated.' }
      format.json { head :no_content }
    end
  end
  
  def toggle_status
    if @blog.draft?
      @blog.published! 
    elsif @blog.published?
      @blog.draft!
    end
    redirect_to blog_path(@blog), notice: 'Blog status has been updated.'
  end

  private
    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end
    
    def set_guest
      @guest = User.friendly.find(params[:guest_id])
    end

    def blog_params
      params.require(:blog).permit(:title, :body, :user_id, :guest_id, :tag_list, :status, :image)
    end
end
