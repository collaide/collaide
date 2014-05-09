class Users::SessionsController < Devise::SessionsController
  def create
    logger.debug warden.authenticate!(auth_options).inspect + 'kajbfksjdbfskdbf'
    super
  end
end