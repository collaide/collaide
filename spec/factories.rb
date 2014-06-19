# -*- encoding : utf-8 -*-
FactoryGirl.define do

  sequence(:random_string) {|n| "Lorem ipsume #{n}" }
  sequence(:name) { |n| "Domain #{n}"}

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "admin#{n}@example.com"}
    role :super_admin
    password "password"
    password_confirmation "password"
  end
  factory :normal_user, class: 'User' do
    sequence(:name)  { |n| "Person #{n}" }
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

  factory :domain do  |domain|
    sequence(:name) { |n| "Domain #{n}"}
    sequence(:description) {|n| "Lorem ipsume #{n}" }
  end

  factory :document, class: 'Document::Document' do |document|
    author "salut"
    description "c'est une déscription"
    language "Français"
    number_of_pages 2
    realized_at {2.years.ago}
    sequence(:title) { |n| "Document #{n}"}
    domains { [(FactoryGirl.create :domain)] }
    study_level :university
    document_type { FactoryGirl.create :document_type }
    asset { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'download', 'asDF.tiff')) }
    user {FactoryGirl.create(:user)}
  end

  factory :document_type, class: 'Document::Type' do
    sequence(:name) { |n| "Document type  #{n}"}
    sequence(:description) {|n| "Lorem ipsume #{n}" }
  end

  factory :sale_book, class: 'Advertisement::SaleBook' do
    sequence(:title) { |n| "Livre #{n}"}
    description 'Une annonce'
    active true
    price 20
    currency :CHF
    #study_level :university
    #domains { [(FactoryGirl.create :domain)] }
    #user {FactoryGirl.create(:user)}
    book {FactoryGirl.create(:book)}
  end

  factory :book, class: 'Book' do
    sequence(:title) { |n| "Livre #{n}"}
    authors 'moi'
    description 'salut'
    isbn_10 3333333333
    isbn_13 3333333333333
  end

  factory :group, class: 'Group::Group' do |group|
    name "Name group"
    description "c'est une déscription"
  end

  factory :work_group, class: 'Group::WorkGroup' do
    sequence(:name) { |n| "Public work group #{n}" }
  end

  factory :comment, class: 'Comment' do
    sequence(:title) { |n| "Comment number #{n}"}
    comment 'un commentaire'
    owner { FactoryGirl.create :normal_user}
  end

  factory :status, class: 'Topic' do
    message 'un status'
    writer { FactoryGirl.create :normal_user }
  end
  factory :invitation, class: 'Group::Invitation' do
    sender { FactoryGirl.create :normal_user }
    receiver { FactoryGirl.create :normal_user }
  end
  factory :email_invitation, class: 'Group::EmailInvitation' do
    sequence(:email) { |n| "salut#{n}@example.com"}
    message 'salut!'
    secret_token 'aaa'
    user { FactoryGirl.create :normal_user }
  end
end
