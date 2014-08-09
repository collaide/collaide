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

Then /^he should see the welcome message$/ do
  page.should have_content 'Connecté avec succès.'
end

Then /^he should see a signout link$/ do
  page.should have_link('Déconnexion', href: destroy_user_session_path)
end


Given(/^a user visits the welcome page$/) do
  visit root_path
end

When(/^he click the sign in button$/) do
  click_link 'header-sign-in-button'
end

Then(/^he should see the sign in form in the right panel$/) do
  should have_selector '.off-canvas-wrap.move-left'
end

When(/^he submit invalid information for the in page form$/) do
  click_button 'offcanvas-connection-submit'
end

Then(/^he should see an error message in the right panel$/) do
  should have_selector 'aside form div.alert-box.alert'
end

When(/^he submit valid information for the in page form$/) do
  fill_in 'offcanvas-connection_user_email',    with: @normal_user.email
  fill_in 'offcanvas-connection_user_password', with: 'password'
  click_button 'offcanvas-connection-submit'
end