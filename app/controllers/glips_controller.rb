class GlipsController < ApplicationController
  before_action :set_glip, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:tag]
      @glips = Glip.tagged_with(params[:tag])
    else
       @glips = Glip.all.order("created_at DESC")
    end
  end

  def show
    @commentable = @glip
    @comments = @commentable.comments
    @comment = Comment.new
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

  private
    def set_glip
      @glip = Glip.find(params[:id])
    end

    def glip_params
      params.require(:glip).permit(:title, :content, :user_id, :tag_list, :completion_criteria)
    end
end
