class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include DeviseWhitelist
  include DefaultPageContent
  
  helper_method :old_enough
  
  def old_enough(user)
    (user.birthdate.to_date + 16.years) < Date.today
  end
end