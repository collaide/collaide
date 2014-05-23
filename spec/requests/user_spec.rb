# -*- encoding : utf-8 -*-
require 'rspec'

describe 'User' do
  describe 'manage the profil'
  it 'edits' do
    sign_in_as_a_valid_user
    get '/users/edit'
    post '/users', user: {email: get_super_user.email, name: get_super_user.name, password: get_super_user.password, password_confirmation: get_super_user.password_confirmation, current_password: get_super_user.password}
    #redirect to main page
  end
end
