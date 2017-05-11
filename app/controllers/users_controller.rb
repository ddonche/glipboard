class UsersController < ApplicationController
  
  def index
    @page_title = "Glipboard Users"
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @page_title = @user.username
    @blogs = @user.blogs
    @glips = @user.glips
    @everything = (@blogs + @glips).sort{|b,a| a.updated_at <=> b.updated_at }
    @result = @everything.class.name
  end
  
end