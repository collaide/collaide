# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: member_message_inboxes
#
#  id         :integer          not null, primary key
#  is_viewed  :boolean          default(FALSE)
#  viewed_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :integer
#  user_id    :integer
#

# -*- encoding : utf-8 -*-
class Member::Message::Inbox < ActiveRecord::Base
  attr_accessible :is_viewed, :viewed_at

  belongs_to :user
  belongs_to :message, :class_name => 'Member::Message'
end
