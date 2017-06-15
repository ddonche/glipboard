class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @group = Group.friendly.find(params[:group_id])
    Membership.create!(user_id: @user.id, group_id: @group.id)
    redirect_to @group
  end

  def destroy
    @group = Group.friendly.find(params[:group_id])
    @membership = current_user.memberships.find_by(group_id: @group.id)
    @membership.delete
    redirect_to groups_path
  end
end