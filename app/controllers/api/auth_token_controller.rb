class Api::AuthTokenController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  prepend_before_filter :disable_devise_trackable

  def create
    u = User.find_by email: params[:email]
    if not u or !u.valid_password? params[:password]
      respond_to do |format|
        format.json {render json: {error: I18n.t('devise.failure.invalid')}, status: 401}
      end
      return
    end
    u.authentication_token = Devise.friendly_token
    u.save
    respond_to do |format|
      format.json {render json: {token: u.authentication_token, id: u.id, name: u.to_s, email: u.email, csrf: form_authenticity_token}}
    end
  end

  def destroy

  end

  private

  def auth_token_params
    params
  end

  def disable_devise_trackable
    request.env['devise.skip_trackable'] = true
  end
end
