# -*- encoding : utf-8 -*-
FactoryGirl.define do

  sequence(:random_string) {|n| "Lorem ipsume #{n}" }
  sequence(:name) { |n| "Domain #{n}"}

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
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

  end

  factory :study_level, class: 'Document::StudyLevel' do |study_level|
    sequence(:name) { |n| "Study Level #{n}"}
    sequence(:description) {|n| "Lorem ipsume #{n}" }
  end

  factory :document_type, class: 'Document::Type' do
    sequence(:name) { |n| "Document type  #{n}"}
    sequence(:description) {|n| "Lorem ipsume #{n}" }
  end
end
