class AuthTokenController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    logger.debug auth_token_params.inspect
    u = User.find_by email: params[:email]
    if not u or !u.valid_password? params[:password]
      logger.debug u.inspect
      logger.debug u.valid_password? params[:password]
      logger.debug params[:password].inspect
      respond_to do |format|
        format.json {render json: {error: 'cannot authenticate user'}, status: 401}
      end
      return
    end
    u.authentication_token = Devise.friendly_token
    u.save
    respond_to do |format|
      format.json {render json: {token: u.authentication_token}}
    end
  end

  def destroy

  end

  private

  def auth_token_params
    params
  end
end