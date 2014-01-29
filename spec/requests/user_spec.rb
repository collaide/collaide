require 'rspec'

describe 'User' do
  describe 'manage the profil'
  it 'edits' do
    sign_in_as_a_valid_user
    get '/fr/membre/modifier'
  end
end