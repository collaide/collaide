# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: member_friend_demands
#
#  id                 :integer          not null, primary key
#  message            :text
#  user_has_sent_id   :integer
#  user_is_invited_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

# -*- encoding : utf-8 -*-
class Member::Friend::Demand < ActiveRecord::Base

  belongs_to :user_has_sent, class_name: 'User'
  belongs_to :user_is_invited, class_name: 'User'
end
