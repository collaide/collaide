# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: group_groups
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  password               :string(255)
#  type                   :string(255)
#  can_index_members      :string(255)
#  can_read_member        :string(255)
#  can_delete_member      :string(255)
#  can_write_file         :string(255)
#  can_index_files        :string(255)
#  can_read_file          :string(255)
#  can_delete_file        :string(255)
#  can_index_statuses     :string(255)
#  can_write_status       :string(255)
#  can_delete_status      :string(255)
#  can_create_invitation  :string(255)
#  can_manage_invitations :string(255)
#  description            :text
#  main_group_id          :integer
#  user_id                :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class Group::WorkGroup < Group::Group

  def init
    super
    self.can_read_status << Group::Roles::MEMBER
    self.can_index_activity << Group::Roles::MEMBER
    self.can_index_members << Group::Roles::MEMBER
    self.can_read_member << Group::Roles::MEMBER
    self.can_write_file << Group::Roles::MEMBER
    self.can_index_files << Group::Roles::MEMBER
    self.can_read_file << Group::Roles::MEMBER
    self.can_delete_file << Group::Roles::MEMBER
    self.can_index_statuses << Group::Roles::MEMBER
    self.can_write_status << Group::Roles::MEMBER
    self.can_create_invitation << Group::Roles::MEMBER
  end
end
