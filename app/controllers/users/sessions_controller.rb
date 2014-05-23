class Users::SessionsController < Devise::SessionsController
  def create
    user_params = params[:user]
    user = User.find_by email: user_params[:email]
    password = user_params[:password]
    if user and user.old_user and Digest::MD5.hexdigest(password) == user.old_password
      user.password = password
      user.password_confirmation = password
      user.old_user = false
      if user.save
        self.resource = user
      end
    else
      self.resource = warden.authenticate!(auth_options)
    end
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
end