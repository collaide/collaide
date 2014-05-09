require 'spec_helper'

describe 'Sign in a old user' do
  let(:user) { FactoryGirl.create :old_user }
  before(:each) do
    I18n.locale = :fr
    post user_session_path, {"user"=>{"email"=>user.email, "password"=>'old_password', "remember_me"=>"1"}, "commit"=>"Connexion"}
  end
  context 'after sign in he' do
    it 'redirect to root_path' do
      expect(response).to redirect_to(root_path)
    end
    it 'can sign in again' do
      new_user = User.find user.id
      new_user.valid_password?('old_password').should be_true
    end
    it 'is normal user' do
      new_user = User.find user.id
      new_user.old_user?.should be_false
    end
  end
end

describe 'Sign in a normal user' do
  let(:user) { FactoryGirl.create :normal_user }
  before(:each) do
    I18n.locale = :fr
    post user_session_path, {"user"=>{"email"=>user.email, "password"=>'password', "remember_me"=>"1"}, "commit"=>"Connexion"}
  end
  context 'after sign in he' do
    it 'redirect to root_path' do
      expect(response).to redirect_to(root_path)
    end
    it 'is normal user' do
      new_user = User.find user.id
      new_user.old_user?.should be_false
    end
  end
end