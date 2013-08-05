class Member::Message::Inbox < ActiveRecord::Base
  attr_accessible :is_viewed, :viewed_at

  belongs_to :user
  belongs_to :message, :class_name => 'Member::Message'
end
