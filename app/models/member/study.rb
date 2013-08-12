# == Schema Information
#
# Table name: member_studies
#
#  id                  :integer          not null, primary key
#  started_at          :date
#  ended_at            :date
#  orientation         :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  member_scolarity_id :integer
#

# -*- encoding : utf-8 -*-
class Member::Study < ActiveRecord::Base
  attr_accessible :ended_at, :orientation, :started_at

  belongs_to :scolarity, :class_name => 'Member::Scolarity'
end
