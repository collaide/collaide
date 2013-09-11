# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: User_group_Users
#
#  id              :integer          not null, primary key
#  is_admin        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  User_group_id :integer
#

# -*- encoding : utf-8 -*-
class User::Group::User < ActiveRecord::Base
  attr_accessible :is_admin

  belongs_to :user
  belongs_to :User_group, :class_name => 'User::Group::Group'
end
