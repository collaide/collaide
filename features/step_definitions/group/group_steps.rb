Given(/^There exists a work group$/) do
  @work_group = FactoryGirl.create(:work_group)
end

Given(/^I am a member of a work group$/) do
  @work_group = FactoryGirl.create(:work_group)
  @work_group.add_members(@normal_user)
  @work_group.save
end