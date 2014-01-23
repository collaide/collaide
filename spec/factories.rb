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
    sequence(:title) { |n| "Domain #{n}"}
    domains { [(FactoryGirl.create :domain)] }
    study_level { FactoryGirl.create :study_level }
    document_type { FactoryGirl.create :document_type }
    files { [(FactoryGirl.create :files)] }

  end

  factory :study_level, class: 'Document::StudyLevel' do |study_level|
    sequence(:name) { |n| "Study Level #{n}"}
    sequence(:description) {|n| "Lorem ipsume #{n}" }
  end

  factory :document_type, class: 'Document::Type' do
    sequence(:name) { |n| "Document type  #{n}"}
    sequence(:description) {|n| "Lorem ipsume #{n}" }
  end

  factory :files, class: 'CFile::CFile' do
    rights %w[read write]
  end
end
