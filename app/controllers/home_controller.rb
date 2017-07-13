class HomeController < ApplicationController
  
  def index
    @glip_count = Glip.count
  end
  
end