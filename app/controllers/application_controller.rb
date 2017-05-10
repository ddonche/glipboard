class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include DeviseWhitelist
  
  before_filter :set_title
  
  def set_title
    @page_title = "Glipboard | Go Glip Yourself"
  end
end