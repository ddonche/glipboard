class UsersController < ApplicationController

  def index
    @page_title = "Glipboarders"
    @users = User.all
  end
  
  def show
    @user = User.friendly.find(params[:id])
    @page_title = @user.username
    @articles = @user.articles
    @glips = @user.glips
    @logs = @user.logs
    @almost_everything = (@articles + @glips).sort{|b,a| a.updated_at <=> b.updated_at }
    @everything = (@almost_everything + @logs).sort{|b,a| a.updated_at <=> b.updated_at }
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
end