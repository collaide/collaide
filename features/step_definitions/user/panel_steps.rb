When(/^I visit "(.*?)" for "([^"]*)"$/) do |path, role|
  visit eval("#{path}_path(#{@login[role].id})")
end

Then(/^I should "(.*?)" "(.*?)" for "(.*?)"$/) do |visit, path, role|
  real_path = eval("#{path}_path(#{@login[role].id})")
  if visit == 'see'
    expect(current_path).to eq(real_path)
  else
    expect(current_path).to_not eq(real_path)
  end

end