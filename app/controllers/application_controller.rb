class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include DeviseWhitelist
  include DefaultPageContent
  
  helper_method :old_enough
  
  def old_enough(user)
    (user.birthdate.to_date + 16.years) < Date.today
  end
  # saves the location before loading each page so we can return to the
  # right page. If we're on a devise page, we don't want to store that as the
  # place to return to (for example, we don't want to return to the sign in page
  # after signing in), which is what the :unless prevents
  before_action :store_location, :unless => :devise_controller?
  before_action :set_notifications

  private
  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end
  
  def set_notifications
    if user_signed_in?
      @notifications = Notification.where({ read: false, recipient_id: current_user.id })
    end
  end
  
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end
end