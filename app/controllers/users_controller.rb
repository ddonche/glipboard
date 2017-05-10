class UsersController < ApplicationController
  
  def index
    @page_title = "Glipboard Users"
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @page_title = @user.username
  end
  
end