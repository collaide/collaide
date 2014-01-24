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

  ROLES = [:admin, :writer]
  #attr_accessible :description, :name, :password, :password_confirmation,
  #
  #                :can_index_members,
  #                :can_read_member,
  #                :can_delete_member,
  #
  #                :can_write_file,
  #                :can_index_files,
  #                :can_read_file,
  #                :can_delete_file,
  #
  #                :can_index_statuses,
  #                :can_write_status,
  #                :can_delete_status,
  #
  #                :can_create_invitation,
  #                :can_manage_invitations
  has_repository

  serialize :can_index_members, Array
  serialize :can_read_member, Array
  serialize :can_delete_member, Array

  serialize :can_write_file, Array
  serialize :can_index_files, Array
  serialize :can_read_file, Array
  serialize :can_delete_file, Array

  serialize :can_index_statuses, Array
  serialize :can_write_status, Array
  serialize :can_delete_status, Array

  serialize :can_create_invitation, Array
  serialize :can_manage_invitations, Array

  belongs_to :main_group, class_name: 'Group::Group'
  has_many :sub_groups, class_name: 'Group::Group'
  has_many :statuses, class_name: 'Status', as: :owner
  has_many :members, through: :group_members
  has_many :invitation, class_name: 'Group::invitation'

  validates :name, presence: true, length: {minimum: 3}

  validates :password, length: {minimum: 4}, confirmation: true
  validates_presence_of :password_confirmation

  after_initialize :init

  def init
    self.can_delete_member << Group::Roles::ADMIN
    self.can_write_file << Group::Roles::MEMBER
    self.can_delete_file << Group::Roles::MEMBER
    self.can_delete_status << Group::Roles::ADMIN
    self.can_manage_invitations << Group::Role::ADMIN
  end

end

class Group::Roles
  ADMIN = :admin
  WRITER = :writer
  MEMBER = :member
end
