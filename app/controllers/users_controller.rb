class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_user, except: [:index, :reputable]

  def index
    @page_title = "Glipboarders"
    @users = User.confirmed.order('created_at DESC').page(params[:page]).per(20)
  end
  
  def reputable
    @page_title = "Most Reputable Glipboarders"
    @users = User.confirmed.order(reputation: :desc).page(params[:page]).per(20)
  end
  
  def show
    @page_title = @user.username
    @articles = @user.articles.where({ status: "published" })
    @glips = @user.glips.where({ privacy: "shown" })
    @logs = @user.logs
    @groups = @user.groups
    @almost_everything = (@articles + @glips).sort{|b,a| a.updated_at <=> b.updated_at }
    @everything_prepage = (@almost_everything + @logs).sort{|b,a| a.updated_at <=> b.updated_at }
    @everything = Kaminari.paginate_array(@everything_prepage).page(params[:page]).per(20)
    @log_glips = @user.glips.order("created_at DESC").page(params[:page]).per(10)
  end
  
  def following
    @title = "Following"
    @groups = @user.groups
    @users = @user.following.page(params[:page]).per(25)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @groups = @user.groups
    @users = @user.followers.page(params[:page]).per(25)
    render 'show_follow'
  end
  
  def glips
    @groups = @user.groups
    @glips = @user.glips.where({ privacy: "shown" }).page(params[:page]).per(15)
    @log_glips = @user.glips.order("created_at DESC").page(params[:page]).per(10)
  end
  
  def private_glips
    @groups = @user.groups
    @glips = @user.glips.where({ privacy: "hidden" }).page(params[:page]).per(15)
    @log_glips = @user.glips.order("created_at DESC").page(params[:page]).per(10)
  end
  
  def groups
    @groups = @user.groups.imaged.order('created_at DESC').page(params[:page]).per(25)
    @new_groups = @user.groups.unimaged.order('created_at DESC').page(params[:page]).per(25)
    @log_glips = @user.glips.order("created_at DESC").page(params[:page]).per(10)
  end
  
  def articles
    @groups = @user.groups
    @articles = @user.articles.page(params[:page]).per(15)
    @log_glips = @user.glips.order("created_at DESC").page(params[:page]).per(10)
  end
  
  def logs
    @groups = @user.groups
    @logs = @user.logs.page(params[:page]).per(25)
    @log_glips = @user.glips.order("created_at DESC").page(params[:page]).per(10)
  end
  
  def membership
    @groups = @user.groups.page(params[:page]).per(25)
    render 'show_groups'
  end
  
  private
  
  def set_user
    @user  = User.friendly.find(params[:id])
  end
  
end