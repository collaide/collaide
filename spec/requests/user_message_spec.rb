require 'rspec'

describe 'use the messagerie' do

  it 'creates a message' do
    sign_in_as_a_valid_user
    post('/fr/messages', user_message: {user_ids: [get_super_user.id], subject: 'asd', body: 'asf'})
    response.status.should eq(200)
  end
end