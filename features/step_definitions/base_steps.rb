Given /^a (.*?) user has an account$/ do |role|
  sym = "#{role}_user"
  instance_variable_set '@' + sym, FactoryGirl.create(sym.to_sym)
end

Given(/^the following users$/) do |table|
  @login = {}
  table.hashes.each do |role|
    # Given "a #{user['user']} has an account"
    @login[role['role']] = FactoryGirl.create("#{role['role']}_user".to_sym)
  end
end

Given(/^I am logged in as "([^"]*)"$/) do |role|
  unless role.blank?
    visit new_user_session_path
    fill_in "connection_user_email",    with: @login[role].email
    fill_in "connection_user_password", with: 'password'
    click_button "connection_submit"
  end
end

And(/^I am authenticated as a "([^"]*)" user$/) do |role|
  Given("a #{role} user has an account")
  Given('the normal user submits valid signin information')
end