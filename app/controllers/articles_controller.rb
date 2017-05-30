class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :upvote, :downvote, 
                                      :helped, :toggle_feature, :toggle_status]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @page_title = "Articles"
    if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.order('created_at DESC').page(params[:page]).per(20)
    end
  end

  def show
    @page_title = @article.title
    @commentable = @article
    @comments = @commentable.comments
    @comment = Comment.new
  end
  
  def helped
  end

  def new
    @article = current_user.articles.build
  end

  def edit
  end

  def create
    @article = current_user.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was a success!' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
      else
        format.html { render :edit }
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
  
  def upvote
    @article.upvote_by current_user
    
    voltaire_up(1, :reputation, @article.user_id)
    redirect_to :back
  end
  
  def downvote
    @article.downvote_by current_user

    voltaire_down(1, :reputation, @article.user_id)
    redirect_to :back
  end

  private
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :user_id, :tag_list)
    end
end
