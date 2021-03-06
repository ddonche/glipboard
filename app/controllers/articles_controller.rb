class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :upvote, :downvote, 
                                      :helped, :toggle_feature, :toggle_status]
  before_action :authenticate_user!, except: [:index, :show, :featured]
  access all: [:show, :index, :new, :create, :featured, :update, :edit, :destroy, :toggle_status], 
                user: {except: [:toggle_feature]}, admin: :all
  
  def index
    @page_title = "Articles"
    if params[:tag]
      @articles = Article.where({ status: "published" }).tagged_with(params[:tag])
    else
      @articles = Article.where({ status: "published" }).order('created_at DESC').page(params[:page]).per(20)
    end
  end
  
  def featured
    @page_title = "Featured Articles"
    @articles = Article.where({ feature: "featured" }).order("created_at DESC").page(params[:page]).per(20)
  end
  
  def drafts
    @page_title = "Your Drafts"
    @user = current_user
    @articles = @user.articles.where({ status: "draft" }).order("updated_at DESC").page(params[:page]).per(20)
  end

  def show
    @page_title = @article.title
    @user = @article.user
    @commentable = @article
    @comments = @commentable.comments.order("created_at DESC")
    @comment = Comment.new
    @glips = @article.glips.order("created_at DESC")
    @mentorship = Mentorship.new
  end

  def new
    @article = current_user.articles.build
    respond_to do |format| 
      format.html
      format.js
    end
  end

  def edit
    @mentorship = Mentorship.new
    @glips = @article.glips.order("created_at DESC")
    @user = @article.user
    @commentable = @article
    @comments = @commentable.comments
    @comment = Comment.new
    respond_to do |format|   
      format.html
      format.js
    end
  end

  def create
    @article = current_user.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_path(@article), notice: 'Article was a success!' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @mentorship = Mentorship.new
    @glips = @article.glips.order("created_at DESC")
    @user = @article.user
    @commentable = @article
    @comments = @commentable.comments
    @comment = Comment.new
    if current_user == @article.user
      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was eradicated.' }
      format.json { head :no_content }
    end
  end
  
  def toggle_feature
    if @article.standard?
      @article.featured!
      Notification.create!(article_id: @article.id, recipient_id: @article.user_id, 
                            notified_by_id: "17", notification_type: "feature")
      
      voltaire_up(15, :reputation, @article.user_id)
    elsif @article.featured?
      @article.standard!
      
      voltaire_down(15, :reputation, @article.user_id)
    end
    redirect_to article_path(@article), notice: 'Article status has been updated.'
  end
  
  def toggle_status
    if @article.draft?
      @article.published! 
    elsif @article.published?
      @article.draft!
    end
    redirect_to article_path(@article), notice: 'Article status has been updated.'
  end
  
  def toggle_blog
    if @article.notblog?
      @article.blog!
    elsif @article.blog?
      @article.notblog!
    end
    redirect_to article_path(@article), notice: 'Article blog status updated.'
  end
  
  def upvote
    if @article.user != current_user
      @article.upvote_by current_user
    
      voltaire_plus(1, :reputation, @article.user_id)
      respond_to do |format|
        format.html { redirect_to @article }
        format.js
      end
    end
  end
  
  def downvote
    if @article.user != current_user
      @article.downvote_by current_user
  
      voltaire_minus(1, :reputation, @article.user_id)
      respond_to do |format|
        format.html { redirect_to @article }
        format.js
      end
    end
  end

  private
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :user_id, :tag_list, :status, :image)
    end
end
