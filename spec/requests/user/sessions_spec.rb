require 'spec_helper'

describe 'Users::SessionsController' do
  it 'signs in a user' do
    I18n.locale = :fr
    user = FactoryGirl.create :normal_user
    post user_session_path, {"user"=>{"email"=>user.email, "password"=>user.password, "remember_me"=>"1"}, "commit"=>"Connexion"}
    expect(response).to redirect_to(root_path)

  end
end