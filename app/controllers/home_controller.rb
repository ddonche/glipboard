class HomeController < ApplicationController
  
  def index
    @blogs = Blog.all
    @glips = Glip.all
    @everything = (@blogs + @glips).sort{|b,a| a.created_at <=> b.created_at }
  end
  
end