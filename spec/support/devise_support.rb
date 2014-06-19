# -*- encoding : utf-8 -*-
module ValidUserRequestHelper
  # Define a method which signs in as a valid user.
  def sign_in_as_a_valid_user
    # ASk factory girl to generate a valid user for us.
    @user ||= FactoryGirl.create :user

    # We action the login request using the parameters before we begin.
    # The login requests will match these to the user we just created in the factory, and authenticate us.
    post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => @user.password
  end

  def sign_in_as_normal_user
    @normal_user ||= FactoryGirl.create :normal_user
    post_via_redirect user_session_path, 'user[email]' => @normal_user.email, 'user[password]' => @normal_user.password
  end

  def sign_in_user(user)
    visit new_user_session_path
    fill_in "Adresse e-mail",    with: user.email
    fill_in "Mot de passe", with: user.password
    click_button "Connexion"
  end

  def get_super_user
    @user ||= FactoryGirl.create :user
  end
end
