class HomeController < ApplicationController
  
  def index
    @blogs = Blog.all
    @glips = Glip.all
    @everything = (@blogs + @glips).sort{|b,a| a.updated_at <=> b.updated_at }
  end
  
end