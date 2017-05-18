class TagsController < ApplicationController
  
  def index
  end
  
  def show
    @blogs = Blog.tagged_with(params[:tag])
    @glips = Glip.tagged_with(params[:tag])
    @everything = (@blogs + @glips).sort{|b,a| a.created_at <=> b.created_at }
    @pager = Kaminari.paginate_array(@everything).page(params[:page]).per(25)
  end
  
end