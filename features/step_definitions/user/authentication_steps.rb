# -*- encoding : utf-8 -*-
Given /^a user visits the signin page$/ do
  visit new_user_session_path
end

When /^he submits invalid signin information$/ do
  click_button "connection_submit"
end

Then /^he should see an error message$/ do
  page.should have_selector('div.alert.alert-box')
end



When /^the normal user submits valid signin information$/ do
    visit new_user_session_path
    fill_in "connection_user_email",    with: @normal_user.email
    fill_in "connection_user_password", with: 'password'
    click_button "connection_submit"
end

Then /^he should see his profile page$/ do
  page.should have_content 'Connecté avec succès.'
end

Then /^he should see a signout link$/ do
  page.should have_link('Déconnexion', href: destroy_user_session_path)
end
