Given(/^There exists a work group$/) do
  @work_group = FactoryGirl.create(:work_group)
end

And(/^the group has a notification for a file created (\d+) hour ago$/) do |hour|
  @notifications ||= {}
  @notifications[hour] = FactoryGirl.create(:api_notif_file_created)
  @notifications[hour].created_at = Time.now-hour.to_i.hours
  @work_group.notifications << @notifications[hour]
  @work_group.save
end

When(/^a notification about a file created between (\d+) hour ago and now should exists$/) do |hour|
  time = Time.now-hour.to_i.hours
  @work_group.reload.notifications.find_for_api(time, 'file_created').should include @notifications[hour]
end

And(/^not one from (\d+) hour ago$/) do |hour|
  time = Time.now-hour.to_i.hours-1.minutes
  @work_group.reload.notifications.find_for_api(time, 'file_created').should_not include @notifications[hour]
end