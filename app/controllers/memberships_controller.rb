class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.friendly.find(params[:user_id])
    group = Group.friendly.find(params[:group_id])
    current_user.join(group)
    redirect_to group
  end

  def destroy
    group = Group.friendly.find(params[:id])
    user = Membership.find(params[:id]).group
    current_user.leave(group)
    redirect_to groups_path
  end
end