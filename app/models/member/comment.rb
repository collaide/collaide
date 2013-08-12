# == Schema Information
#
# Table name: member_comments
#
#  id               :integer          not null, primary key
#  message          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  member_status_id :integer
#  user_id          :integer
#

# -*- encoding : utf-8 -*-
class Member::Comment < ActiveRecord::Base
  attr_accessible :message

  belongs_to :status, :class_name => 'Member::Status'
  belongs_to :user


end
