# == Schema Information
#
# Table name: member_statuses
#
#  id              :integer          not null, primary key
#  message         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  member_group_id :integer
#

# -*- encoding : utf-8 -*-
class Member::Status < ActiveRecord::Base
  attr_accessible :message

  belongs_to :user, inverse_of: :statuses
  belongs_to :group, :class_name => 'Member::Group', inverse_of: :statuses

  has_many :comments, :class_name => 'Member::Comment', inverse_of: :statuses
end
