class RegistrationsController < Devise::RegistrationsController
  protected
  
  def resource_name
    :user
  end
  
  wrap_parameters :user, include: [:username, :email, :password, :password_confirmation, :picture]

  def after_sign_up_path_for(resource)
    root_path
  end
end