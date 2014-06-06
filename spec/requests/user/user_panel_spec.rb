require 'spec_helper'

describe 'visit user\'s panel' do
  let(:user) { FactoryGirl.create(:user) }
  describe 'when not connected' do
    it 'see users\s documents' do
      visit user_documents_path(user)
      page.should have_content 'Documents de ' + user.name
    end
    it 'see advertisement\s documents' do
      visit user_advertisements_path(user)
      page.should have_content 'Annonces de ' + user.name
    end
    it 'do not see user\'s invitations' do
      visit user_invitations_path(user)
      page.should_not have_content 'Invitations'
    end
  end
  describe 'when connected' do
    let(:normal_user) { FactoryGirl.create(:normal_user) }
    it 'see his invitations page' do
      post_via_redirect user_session_path, 'user[email]' => normal_user.email, 'user[password]' => normal_user.password
      visit user_invitations_path(normal_user)
      page.should have_content 'Invitations'
    end
    it 'do not see other invitations page' do
      visit user_invitations_path(user)
      page.should_not have_content 'Invitations'
    end
  end
end