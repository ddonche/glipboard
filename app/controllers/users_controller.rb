class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def index
    @page_title = "Glipboarders"
    @users = User.order('created_at DESC').page(params[:page]).per(20)
  end
  
  def show
    @user = User.friendly.find(params[:id])
    @page_title = @user.username
    @articles = @user.articles.where({ status: "published" })
    @glips = @user.glips
    @logs = @user.logs
    @almost_everything = (@articles + @glips).sort{|b,a| a.updated_at <=> b.updated_at }
    @everything_prepage = (@almost_everything + @logs).sort{|b,a| a.updated_at <=> b.updated_at }
    @everything = Kaminari.paginate_array(@everything_prepage).page(params[:page]).per(9)
  end
  
  def following
    @title = "Following"
    @user  = User.friendly.find(params[:id])
    @users = @user.following.page(params[:page]).per(25)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.friendly.find(params[:id])
    @users = @user.followers.page(params[:page]).per(25)
    render 'show_follow'
  end
  
end