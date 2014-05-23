# -*- encoding : utf-8 -*-
class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token

  #def all
  #  p env["omniauth.auth"]
  #  user = User.from_omniauth(env["omniauth.auth"], current_user)
  #  if user.persisted?
  #    flash[:notice] = "You are in..!!! Go to edit profile to see the status for the accounts"
  #    sign_in_and_redirect(user)
  #  else
  #    session["devise.user_attributes"] = user.attributes
  #    redirect_to new_user_registration_url
  #  end
  #end
  #
  #def failure
  #  #handle you logic here..
  #  #and delegate to super.
  #  super
  #end
  #
  #
  #alias_method :facebook, :all
  #alias_method :twitter, :all
  #alias_method :linkedin, :all
  #alias_method :github, :all
  ##alias_method :passthru, :all
  #alias_method :google_oauth2, :all

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  #def passthru
  #   self.send(params[:provider])
  #end

end
