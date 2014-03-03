# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: member_friend_friends
#
#  id         :integer          not null, primary key
#  users_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

# -*- encoding : utf-8 -*-
class Member::Friend::Friend < ActiveRecord::Base

  belongs_to :user, :class_name => 'User'
end
