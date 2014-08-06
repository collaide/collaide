FactoryGirl.define do

  factory :super_admin_user, class: 'User' do
    sequence(:name)  { |n| "Super admin #{n}" }
    sequence(:email) { |n| "admin#{n}@example.com"}
    role :super_admin
    password "password"
    password_confirmation "password"
  end
  factory :normal_user, class: 'User' do
    sequence(:name)  { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com"}
    password "password"
    password_confirmation "password"
  end
  factory :old_user, class: 'User' do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "user#{n}@example.com"}
    password "password"
    old_password Digest::MD5.hexdigest('old_password')
    old_user true
    password_confirmation "password"
  end
end