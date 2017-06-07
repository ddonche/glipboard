class CategoriesController < ApplicationController
  before_action :set_group
  before_action :set_category, except: [:new, :create]
  
  def index
  end
  
  def show
    @posts = @group.posts.where({ category_id: @category.id }).page(params[:page]).per(25)
  end
  
  def new
    @category = @group.categories.build
    respond_to do |format|               
      format.js
    end
  end

  def edit
  end

  def create
    @category = @group.categories.build(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to group_path(@group), notice: 'New category created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @group, notice: 'Post category was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to group_url(@group), notice: 'Post category was eradicated.' }
    end
  end
  
  private
    def set_group
      @group = Group.friendly.find(params[:group_id])
    end
    
    def set_category
      @category = Category.friendly.find(params[:id])
    end
  
    def category_params
      params.require(:category).permit(:title, :description, :group_id, :icon)
    end
  
end