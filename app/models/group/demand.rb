# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: group_demands
#
#  id         :integer          not null, primary key
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  group_id   :integer
#

# -*- encoding : utf-8 -*-
class Group::Demand < ActiveRecord::Base
  attr_accessible :message

  belongs_to :user_has_sent, class_name: 'User'

  belongs_to :group, :class_name => 'Group::Group'

  has_and_belongs_to_many :users_are_invited, class_name:  'User'
end
