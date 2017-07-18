class EpisodesController < ApplicationController
  before_action :set_episode, except: [:new, :create]
  before_action :set_podcast, only: [:new, :create, :edit, :update, :destroy, :upvote, :downvote]
  before_action :set_group, except: [:show, :create, :new]
  before_action :authenticate_user!, except: [:index, :show]

  def index
  end
  
  def show
    @group = Group.friendly.find(@episode.podcast.group_id)
  end

  def new
    @episode = @podcast.episodes.new
    respond_to do |format|  
      format.html
      format.js
    end
  end
  
  def create
    @episode = @podcast.episodes.new(episode_params) 
    @episode.user_id = current_user.id if current_user
    if @episode.save
      redirect_to podcast_episode_path(@podcast, @episode), notice: "Episode was created."
    else
      render :new
    end
  end
  
  def edit   
    @episode = Episode.friendly.find(params[:id])
  end
  
  def update
    respond_to do |format|
      if @episode.update(episode_params)
         format.html { redirect_to podcast_episode_path(@podcast, @episode), notice: 'Episode was successfully updated.' }
      else
         format.html { render :edit }
      end
    end
  end

  def destroy
    @episode.destroy
    respond_to do |format|
      format.html redirect_to podcast_episode_path(@podcast, @episode), notice: 'Episode was eradicated.'
    end
  end
  
  def upvote
    if @episode.user_id != current_user.id
      @episode.upvote_by current_user
      
      voltaire_up(1, :reputation, @episode.user_id)
      respond_to do |format|
        format.html { redirect_to podcast_episode_path(@podcast, @episode) }
        format.js
      end
    end
  end
  
  def downvote
    if @episode.user_id != current_user.id
      @episode.downvote_by current_user
      
      voltaire_down(1, :reputation, @episode.user_id)
      respond_to do |format|
        format.html { redirect_to podcast_episode_path(@podcast, @episode) }
        format.js
      end
    end
  end

  private

  def set_episode
    @episode = Episode.friendly.find(params[:id])
  end
  
  def set_podcast
    @podcast = Podcast.friendly.find(params[:podcast_id])
  end
  
  def set_group
    @group = Group.friendly.find(@podcast.group_id)
  end
  
  def episode_params
    params.require(:episode).permit(:title, :content, :user_id, :podcast_id, :image, :audio, :tag_list)
  end
end