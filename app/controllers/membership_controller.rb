class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.friendly.find(params[:id])
    @group = Group.friendly.find(params[:id])
    respond_to do |format|
      format.html { redirect_to @group }
      format.js
    end
  end

  def destroy
    @user = Membership.friendly.find(params[:id])
    @group = Membership.friendly.find(params[:id])
    respond_to do |format|
      format.html { redirect_to groups_path }
      format.js
    end
  end
end