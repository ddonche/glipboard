class PagesController < ApplicationController
  def about
  end
  
  def congrats
    @glips = Glip.original.order('created_at DESC').limit(10)
  end
  
  def contact
  end
  
  def help
  end
  
  def home
  end

end
