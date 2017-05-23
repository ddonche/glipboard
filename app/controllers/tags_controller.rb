class TagsController < ApplicationController
  
  def index
  end
  
  def show
    @articles = Article.tagged_with(params[:tag])
    @glips = Glip.tagged_with(params[:tag])
    @everything = (@articles + @glips).sort{|b,a| a.created_at <=> b.created_at }
    @pager = Kaminari.paginate_array(@everything).page(params[:page]).per(25)
  end
  
end