class RegistrationsController < Devise::RegistrationsController
  protected
  
  def resource_name
    :user
  end
  
  wrap_parameters :user, include: [:username, :email, :password, :password_confirmation, :picture,
                                  :bio, :website, :city, :country]

  def after_sign_up_path_for(resource)
    users_path
  end
end