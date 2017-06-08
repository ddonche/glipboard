class RegistrationsController < Devise::RegistrationsController
  protected
  
  def resource_name
    :user
  end
  
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
  
  wrap_parameters :user, include: [:username, :email, :password, :password_confirmation, :picture,
                                  :bio, :website, :city, :country]

  def after_sign_up_path_for(resource)
    users_path
  end
  
  def after_update_path_for(resource)
    user_path(resource)
  end
end