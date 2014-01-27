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
  has_many :sub_groups, class_name: 'Group::Group', foreign_key: "main_group_id"
  #has_many :statuses, class_name: 'Status', as: :owner
  has_many :group_members#, class_name: 'Group::GroupMember'
  has_many :members, through: :group_members

  has_many :sent_group_invitations, class_name: 'Group::Invitation', as: 'sender'
  has_many :group_invitations, class_name: 'Group::Invitation'
  # A mettre dans User aussi
  has_many :received_group_invitations, class_name: 'Group::Invitation', as: 'receiver'



  validates :name, presence: true, length: {minimum: 2}

  #validates :password, length: {minimum: 1}, confirmation: true
  #validates_presence_of :password_confirmation

  after_initialize :init

  def init
    self.can_delete_member << Group::Roles::ADMIN
    self.can_write_file << Group::Roles::MEMBER
    self.can_delete_file << Group::Roles::MEMBER
    self.can_delete_status << Group::Roles::ADMIN
    self.can_manage_invitations << Group::Roles::ADMIN
  end

  # send an invitation to the receivers
  def send_invitations(receivers, message = '', sender = self)
    if receivers.kind_of?(Array)
      receivers.each do |r|
        invitation = Group::Invitation.new(message: message)
        invitation.sender = sender
        invitation.receiver = r
        self.group_invitations << invitation
      end
    else
      invitation = Group::Invitation.new(message: message)
      invitation.sender = sender
      invitation.receiver = receivers

      self.group_invitations << invitation
    end
  end

  def add_members(members, role = Group::Roles::MEMBER, joined_method = :by_itself)
    if members.kind_of?(Array)
      members.each do |m|
        gm = Group::GroupMember.new
        gm.member = m
        gm.role = role
        gm.joined_method = joined_method
        self.group_members << gm
      end
    else
      gm = Group::GroupMember.new
      gm.member = members
      gm.role = role
      gm.joined_method = joined_method

      self.group_members << gm
    end
  end

end

class Group::Roles
  ALL = :all
  ADMIN = :admin
  WRITER = :writer
  MEMBER = :member
end
