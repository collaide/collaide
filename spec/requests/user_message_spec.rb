# -*- encoding : utf-8 -*-
require 'rspec'

describe 'use the messagerie' do

  it 'creates a message' do
    sign_in_as_a_valid_user
    get('/fr/messages/nouveau')
    post('/fr/messages', user_message: {user_ids: [get_super_user.id], subject: 'asd', body: 'asf'})
    follow_redirect!
  end
end
