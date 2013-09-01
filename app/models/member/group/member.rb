# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: member_group_members
#
#  id              :integer          not null, primary key
#  is_admin        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  member_group_id :integer
#

# -*- encoding : utf-8 -*-
class Member::Group::Member < ActiveRecord::Base
  attr_accessible :is_admin

  belongs_to :user
  belongs_to :member_group, :class_name => 'Member::Group::Group'
end
