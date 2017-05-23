class HomeController < ApplicationController
  
  def index
    @articles = Article.all
    @glips = Glip.all
    @everything = (@articles + @glips).sort{|b,a| a.created_at <=> b.created_at }
  end
  
end