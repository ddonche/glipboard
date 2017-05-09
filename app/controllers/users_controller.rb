class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
  end
  
  def create
    @user = @user.new(allowed_params) 
    if @user.save
      redirect_to root_path, notice: "You have successfully signed up."
    else
      render :new
    end
  end
  
  def edit 
  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(allowed_params)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  private
  
  def allowed_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
end