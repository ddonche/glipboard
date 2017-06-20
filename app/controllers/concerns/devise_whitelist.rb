module DeviseWhitelist 
  extend ActiveSupport::Concern
  
  included do
    before_filter :configure_permitted_parameters, if: :devise_controller?
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :picture, :picture_cache, :remove_picture, 
                                      :bio, :website, :city, :country, :birthdate])
  end
end