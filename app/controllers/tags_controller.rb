class TagsController < ApplicationController
  
  def index
  end
  
  def show
    @articles = Article.tagged_with(params[:tag])
    @glips = Glip.tagged_with(params[:tag])
    @groups = Group.tagged_with(params[:tag])
    @everything = (@articles + @glips)
    @everything_plus = (@everything + @groups).sort{|b,a| a.created_at <=> b.created_at }
    @pager = Kaminari.paginate_array(@everything_plus).page(params[:page]).per(25)
  end
  
end