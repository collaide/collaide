FactoryGirl.define do
  factory :group, class: 'Group::Group' do |group|
    name "Name group"
    description "c'est une déscription"
  end

  factory :work_group, class: 'Group::WorkGroup' do
    sequence(:name) { |n| "Public work group #{n}" }
  end

  factory :topic, class: 'Topic' do
    sequence(:message) {|n| "Topic's message #{n}"}
  end
end