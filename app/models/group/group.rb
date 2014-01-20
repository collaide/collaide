# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: group_groups
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
class Group::Group < ActiveRecord::Base
  attr_accessible :description, :is_public, :name, :password

  has_many :statuses, :class_name => 'User::Status'
  has_many :users, :class_name => 'Group::User'
  has_many :demands, :class_name => 'Group::Demand'

  validates_presence_of :name

  validates :password, length: {minimum: 4}
end
