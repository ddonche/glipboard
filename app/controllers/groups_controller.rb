class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :members]
  before_action :authenticate_user!, except: [:index, :show]
  access all: [:show, :index, :new, :create, :update, :edit], user: {except: [:destroy]}, admin: :all

  def index
    @page_title = "Groups"
    @latest_posts = Post.all.order('created_at DESC').limit(20)
    if params[:tag]
      @groups = Group.tagged_with(params[:tag])
    else
      @groups = Group.imaged.order('created_at DESC').page(params[:page]).per(25)
      @new_groups = Group.unimaged.order('created_at DESC').page(params[:page]).per(25)
    end
  end

  def show
    @page_title = @group.title
    @posts = Post.where({ group_id: @group.id }).order('updated_at DESC').page(params[:page]).per(20)
    @categories = @group.categories
    @creator = User.friendly.find(@group.creator_id)
  end
  
  def members
    @title = "Members"
    @members = @group.users.order('created_at DESC').page(params[:page]).per(25)
    @creator = User.friendly.find(@group.creator_id)
    render 'show_members'
  end

  def new
    @creator_id = current_user.id
    @group = Group.new
  end

  def edit
  end

  def create
    @creator_id = current_user.id
    @group = Group.create(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'You have a new Group!' }
      else
        format.html { render :new, alert: 'There seems to be an error.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def set_group
      @group = Group.friendly.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:title, :description, :creator_id, :tag_list, :picture, :picture_cache, :remove_picture, 
                                    :icon, :banner)
    end
end
