# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: User_friend_demands
#
#  id                 :integer          not null, primary key
#  message            :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_has_sent_id   :integer
#  user_is_invited_id :integer
#

# -*- encoding : utf-8 -*-
class User::Friend::Demand < ActiveRecord::Base
  attr_accessible :message

  belongs_to :user_has_sent, class_name: 'User'
  belongs_to :user_is_invited, class_name: 'User'
end
