class Api::UsersController < ApplicationController

  def valid
    u = User.new(api_user_params)
    respond_to do |format|
      format.json do
        if u.valid?
          render status: :ok, text: 'valid'
        else
          render status: 422, json: {errors: u.errors}.to_json
        end
      end
    end
  end

  private

  def api_user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end