FactoryGirl.define do

  factory :api_notif_file_created, class: 'ApiNotification' do
    notification_type 'file_created'
  end

end