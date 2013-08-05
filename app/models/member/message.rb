class Member::Message < ActiveRecord::Base
  def self.table_name_prefix
    ''
  end
  attr_accessible :is_send, :message, :send_at, :subject

  belongs_to :user_has_send, class_name: 'User'
  has_many :replies, class_name: 'Member::Message'
  has_many :inboxes, :class_name => 'Member::Message::Inbox'
end
