require 'spec_helper'

describe 'visit user\'s panel' do
  let(:admin) { FactoryGirl.create(:user) }
  describe 'when not connected' do
    it 'see users\s documents' do
      visit user_documents_path(admin)
      page.should have_content 'Documents de ' + admin.name
    end
    it 'see advertisement\s documents' do
      visit user_advertisements_path(admin)
      page.should have_content 'Annonces de ' + admin.name
    end
    it 'do not see user\'s invitations' do
      visit user_invitations_path(admin)
      page.should_not have_content 'Invitations'
    end
  end
  describe 'when connected' do
    let(:normal_user) { FactoryGirl.create(:normal_user) }
    before(:each) { sign_in_user(normal_user) }
    it 'see his invitations page' do
      visit user_invitations_path(normal_user)
      page.should have_content 'Invitations'
    end
    it 'do not see other invitations page' do
      visit user_invitations_path(admin)
      page.should_not have_content 'Invitations'
    end
  end
end