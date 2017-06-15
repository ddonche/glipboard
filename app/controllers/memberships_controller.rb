class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:create]

  def create
    @user = current_user
    Membership.create!(user_id: @user.id, group_id: @group.id)
    redirect_to @group
  end

  def destroy
    user = current_user
    @group = Group.find(params[:membership][:group_id])
    membership = user.memberships.find_by(group_id: @group.id)
    membership.destroy
    redirect_to groups_path
  end
  
  private
  def set_group
    @group = Group.friendly.find(params[:group_id])
  end
end