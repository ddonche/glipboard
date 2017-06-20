class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include DeviseWhitelist
  include DefaultPageContent
  
  def old_enough
    @old_enough = (current_user.birthdate.to_date + 16.years) < Date.today
  end
end
