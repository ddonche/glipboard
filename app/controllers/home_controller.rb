class HomeController < ApplicationController
  
  def index
    @articles =  Article.where({ status: "published" })
    @glips =  Glip.all
    @almost_everything = (@articles + @glips).sort{|b,a| a.created_at <=> b.created_at }
    @everything = Kaminari.paginate_array(@almost_everything).page(params[:page]).per(25)
  end
  
end