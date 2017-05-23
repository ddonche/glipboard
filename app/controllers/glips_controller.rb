class GlipsController < ApplicationController
  before_action :set_glip, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :toggle_status]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @page_title = "Glips"
    if params[:tag]
      @glips = Glip.tagged_with(params[:tag])
    else
      @glips = Glip.order('created_at DESC').page(params[:page]).per(25)
    end
  end

  def show
    @page_title = @glip.title
    @commentable = @glip
    @comments = @commentable.comments
    @comment = Comment.new
    @log = Log.new
    @log.user = current_user
  end

  def new
    @glip = current_user.glips.build
  end

  def edit
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
    elsif  @glip.complete?
      @glip.incomplete!
    end
    redirect_to glip_path(@glip), notice: 'Glip status has been updated.'
  end
  
  def upvote
    @glip.upvote_by current_user
    
    #update user reputation in the database
    User.increment_counter(:reputation, @glip.user_id)
    redirect_to :back
  end
  
  def downvote
    @glip.downvote_by current_user
    
    #update user reputation in the database
    User.decrement_counter(:reputation, @glip.user_id)
    redirect_to :back
  end

  private
    def set_glip
      @glip = Glip.friendly.find(params[:id])
    end

    def glip_params
      params.require(:glip).permit(:title, :content, :user_id, :tag_list, :completion_criteria)
    end
end
