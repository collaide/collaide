# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: member_studies
#
#  id          :integer          not null, primary key
#  started_at  :date
#  ended_at    :date
#  orientation :string(255)
#  users_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

# -*- encoding : utf-8 -*-
class Member::Study < ActiveRecord::Base

  belongs_to :user
  belongs_to :school, :class_name => 'Group::School'
end
