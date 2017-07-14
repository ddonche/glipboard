class PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  access all: [:show, :index], premium: [:create, :new, :edit, :update, :destroy], admin: :all
  
  def index
    @page_title = "Podcasts"
    if params[:tag]
      @podcasts = Podcast.tagged_with(params[:tag])
    else
      @podcasts = Podcast.order('created_at DESC').page(params[:page]).per(20)
    end
  end

  def show
    @page_title = @podcast.title
    @user = @podcast.user
  end

  def new
    @podcast = current_user.podcasts.build
    respond_to do |format| 
      format.html
      format.js
    end
  end

  def edit
    @user = @podcast.user
    respond_to do |format|   
      format.html
      format.js
    end
  end

  def create
    @podcast = current_user.podcasts.build(podcast_params)

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to podcast_path(@podcast), notice: 'Your podcast was created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @user = @podcast.user
    if current_user == @podcast.user
      respond_to do |format|
        if @podcast.update(podcast_params)
          format.html { redirect_to @podcast, notice: 'Podcast was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  def destroy
    @podcast.destroy
    respond_to do |format|
      format.html { redirect_to podcasts_url, notice: 'Podcast was eradicated.' }
    end
  end

  private
    def set_podcast
      @podcast = Podcast.friendly.find(params[:id])
    end

    def podcast_params
      params.require(:podcast).permit(:title, :content, :tag_list, :image)
    end
end
