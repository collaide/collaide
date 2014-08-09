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

And(/^clicks the sign up button$/) do
  click_link 'header-sign-up-button'
end

When(/^he submits a valid sign up form$/) do
  user = FactoryGirl.build :normal_user
  fill_in 'offcanvas-signup_user_email', with: user.email
  fill_in 'offcanvas-signup_user_name', with: user.name
  fill_in 'offcanvas-signup_user_password', with: user.password
  fill_in 'offcanvas-signup_user_password_confirmation', with: user.password_confirmation
  click_button 'offcanvas-signup-submit'
end

Then(/^he should see the welcome message for the registration$/) do
  should have_content 'Bienvenue ! Vous vous êtes enregistré(e) avec succès.'
end

When(/^he fills the e\-mail field with invalid e\-mail and focus out$/) do
  fill_in 'offcanvas-signup_user_email', with: 'wrong_email'
  page.execute_script "$('aside #offcanvas-signup_user_email').focus(); $('aside #offcanvas-signup_user_email').focusout()"
end

Then(/^he should see an error message under the e\-mail field$/) do
  should have_selector 'aside div.email small.error'
end

When(/^he submits an invalid sign up form$/) do
  click_button 'offcanvas-signup-submit'
end