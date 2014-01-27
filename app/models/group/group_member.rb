# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: group_members
#
#  id              :integer          not null, primary key
#  is_admin        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  group_id :integer
#

# -*- encoding : utf-8 -*-
class Group::GroupMember < ActiveRecord::Base
  #attr_accessible :is_admin
  extend Enumerize
  enumerize :role, in: [Group::Roles::ADMIN,
                        Group::Roles::WRITER,
                        Group::Roles::ALL]

  # Les membres du group
  belongs_to :member, polymorphic: true

  # Le group
  belongs_to :group, :class_name => 'Group::Group'


end
