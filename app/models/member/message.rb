# == Schema Information
#
# Table name: member_messages
#
#  id         :integer          not null, primary key
#  is_send    :boolean          default(FALSE)
#  send_at    :datetime
#  subject    :string(255)
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  message_id :integer
#

# -*- encoding : utf-8 -*-
class Member::Message < ActiveRecord::Base
  def self.table_name_prefix
    ''
  end
  attr_accessible :is_send, :message, :send_at, :subject

  belongs_to :user_has_send, class_name: 'User'
  has_many :replies, class_name: 'Member::Message'
  has_many :inboxes, :class_name => 'Member::Message::Inbox'
end
