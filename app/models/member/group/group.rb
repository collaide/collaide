# == Schema Information
#
# Table name: member_group_groups
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  is_public   :boolean          default(TRUE)
#  password    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# -*- encoding : utf-8 -*-
class Member::Group::Group < ActiveRecord::Base
  attr_accessible :description, :is_public, :name, :password

  has_one :repository, :class_name => 'CFile::Structure'

  has_many :statuses, :class_name => 'Member::Status'
  has_many :members, :class_name => 'Member::Group::Member'
  has_many :demands, :class_name => 'Member::Group::Demand'

  validates_presence_of :name

  validates :password, length: {minimum: 5}
end
