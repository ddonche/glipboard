class GlipsController < ApplicationController
  before_action :set_glip, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :helpers, :toggle_status]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @page_title = "Glips"
    if params[:tag]
      @glips = Glip.tagged_with(params[:tag])
    else
      @glips = Glip.order('created_at DESC').page(params[:page]).per(20)
    end
  end

  def show
    @page_title = @glip.title
    @user = @glip.user
    @commentable = @glip
    @comments = @commentable.comments.order("created_at DESC")
    @comment = Comment.new
    @log = Log.new
    @log.user = current_user
    @articles = @glip.articles.order("created_at DESC")
    @logs = @glip.logs.order("created_at DESC").page(params[:page]).per(10)
  end
  
  def helpers
  end

  def new
    @glip = current_user.glips.build
    respond_to do |format| 
      format.html
      format.js
    end
  end

  def edit
    @user = @glip.user
    @commentable = @glip
    @comments = @commentable.comments
    @comment = Comment.new
    @log = Log.new
    @log.user = current_user
    @articles = @glip.articles.order("created_at DESC")
    @logs = @glip.logs.order("created_at DESC").page(params[:page]).per(10)
    respond_to do |format| 
      format.html
      format.js
    end
  end

  def create
    @glip = current_user.glips.build(glip_params)

    respond_to do |format|
      if @glip.save
        format.html { redirect_to @glip, notice: 'You have a new Glip!' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @glip.update(glip_params)
        format.html { redirect_to @glip, notice: 'Glip was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @glip.destroy
    respond_to do |format|
      format.html { redirect_to glips_url, notice: 'Glip was eradicated.' }
    end
  end
  
  def toggle_status
    if @glip.incomplete?
      @glip.complete! 
      
    voltaire_up(5, :reputation, @glip.user_id)
    elsif  @glip.complete?
      @glip.incomplete!
      voltaire_down(5, :reputation, @glip.user_id)
    end
    redirect_to glip_path(@glip), notice: 'Glip status has been updated.'
  end
  
  def upvote
    if @glip.user != current_user
      @glip.upvote_by current_user
      
      voltaire_plus(1, :reputation, @glip.user_id)
      respond_to do |format|
        format.html { redirect_to @glip }
        format.js
      end
    end
  end
  
  def downvote
    if @glip.user != current_user
      @glip.downvote_by current_user
      
      voltaire_minus(1, :reputation, @glip.user_id)
      respond_to do |format|
        format.html { redirect_to @glip }
        format.js
      end
    end
  end

  private
    def set_glip
      @glip = Glip.friendly.find(params[:id])
    end

    def glip_params
      params.require(:glip).permit(:title, :content, :user_id, :tag_list, :deadline, :completion_criteria)
    end
end
