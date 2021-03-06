class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:create, :toggle_role]

  def create
    @user = current_user
    Membership.create!(user_id: @user.id, group_id: @group.id)
    voltaire_up(1, :reputation, @group.creator)
    respond_to do |format|
      format.html { redirect_to @group }
      format.js
    end
  end

  def destroy
    user = current_user
    @group = Group.find(params[:membership][:group_id])
    membership = user.memberships.find_by(group_id: @group.id)
    membership.destroy
    voltaire_down(1, :reputation, @group.creator)
    respond_to do |format|
      format.html { redirect_to groups_path }
      format.js
    end
  end
  
  def toggle_role
    if @membership.member?
      @membership.admin! 
    elsif @membership.admin?
      @membership.member!
    end
    redirect_to group_path(@group), notice: 'That user is now an admin.'
  end
  
  private
  def set_group
    @group = Group.friendly.find(params[:group_id])
  end
end