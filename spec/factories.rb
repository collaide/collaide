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
end
