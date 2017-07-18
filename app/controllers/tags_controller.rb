class TagsController < ApplicationController
  
  def index
    @tags = ActsAsTaggableOn::Tag.most_used(100).page(params[:page]).per(40)
  end
  
  def show
    @articles = Article.tagged_with(params[:tag])
    @glips = Glip.tagged_with(params[:tag])
    @groups = Group.tagged_with(params[:tag])
    @podcasts = Podcast.tagged_with(params[:tag])
    @everything = (@articles + @glips + @podcasts)
    @everything_plus = (@everything + @groups).sort{|b,a| a.created_at <=> b.created_at }
    @pager = Kaminari.paginate_array(@everything_plus).page(params[:page]).per(25)
  end
  
  private
  
end