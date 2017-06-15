class MembershipsController < ApplicationController
  before_action :authenticate_user!, :set_group

  def create
    @user = current_user
    Membership.create!(user_id: @user.id, group_id: @group.id)
    redirect_to @group
  end

  def destroy
    current_user.memberships.find_by(group_id: @group.id).destroy
    redirect_to groups_path
  end
  
  private
  def set_group
    @group = Group.friendly.find(params[:group_id])
  end
end