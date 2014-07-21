#pour devise. Permet de rajouter des attributs personalisés et d'éviter le un permitted attributes error
class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  protected

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # my custom fields are :name, :avatar

  def configure_permitted_parameters
    #logger.debug('called from controllers/users/registrations_controller.rb')
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name,
               :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :avatar,
               :email, :password, :password_confirmation, :current_password)
    end
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

end