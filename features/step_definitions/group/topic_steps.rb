And(/^I visit the topic's page of the group$/) do
  visit group_work_group_topics_path(@work_group)
end

When(/^I start a new topic$/) do
  page.should have_content 'Discussions'
  @topic_msg = {title: 'a new topic', msg: 'I say something'}
  fill_in 'Titre', with: @topic_msg[:title]
  fill_in 'topic_message_id', with: @topic_msg[:msg]
  click_button 'Lancer la discussion'
end

Then(/^I sould see the topic I started$/) do
  page.should have_content @topic_msg[:title]
  page.should have_content @topic_msg[:msg]
end

And(/^There are more than (\d+) topics$/) do |count_topics|
  (count_topics.to_i + 10).times do
    @work_group.topics << FactoryGirl.create(:topic)
  end
  @work_group.save
end

Then(/^I should see the pagination$/) do
  page.should have_content 'Suivant'
end