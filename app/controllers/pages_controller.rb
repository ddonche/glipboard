class PagesController < ApplicationController
  def about
  end
  
  def congrats
    @glips = Glip.original.order('created_at DESC').limit(10)
  end
  
  def contact
  end
  
  def content
    @blog = Blog.order("created_at").last
    @articles =  Article.where({ status: "published" })
    @latest_blogs = Blog.where({ status: "published" }).order('created_at DESC').limit(6)
    @glips =  Glip.original
    @randomGlip = Glip.where.not(image: [nil, ""]).order("RANDOM()").first
    @almost_everything = (@articles + @glips).sort{|b,a| a.created_at <=> b.created_at }
    @everything = Kaminari.paginate_array(@almost_everything).page(params[:page]).per(25)
  end
  
  def help
  end
  
  def home
  end
  
  def errors
  end
  
  def conduct
  end

end
