# == Schema Information
#
# Table name: api_notifications
#
#  id                :integer          not null, primary key
#  owner_type        :string(255)
#  owner_id          :integer
#  notification_type :string(255)
#  notifier_type     :string(255)
#  notifier_id       :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe ApiNotification do
  let(:group) {FactoryGirl.create(:work_group)}
  it 'belongs to the group' do
    notif = ApiNotification.new
    group.notifications << notif
    group.save
    group.reload.notifications.should include notif
  end
  it 'finds a notification for a particular api' do
    last_seen = Time.now-1.hours
    notif = FactoryGirl.create :api_notif_file_created
    notif.group = group
    notif.save
    group.reload.notifications.find_for_api(last_seen, 'file_created')
  end
end
