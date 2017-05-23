class UsersController < ApplicationController
  
  def index
    @page_title = "Glipboard Users"
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
  
end