# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: group_groups
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  password               :string(255)
#  type                   :string(255)
#  can_index_activity     :string(255)
#  can_delete_group       :string(255)
#  can_read_topic         :string(255)
#  can_index_members      :string(255)
#  can_read_member        :string(255)
#  can_delete_member      :string(255)
#  can_write_file         :string(255)
#  can_index_files        :string(255)
#  can_read_file          :string(255)
#  can_delete_file        :string(255)
#  can_index_topics       :string(255)
#  can_write_topic        :string(255)
#  can_delete_topic       :string(255)
#  can_create_invitation  :string(255)
#  can_manage_invitations :string(255)
#  description            :text
#  main_group_id          :integer
#  user_id                :integer
#  created_at             :datetime
#  updated_at             :datetime
#

# -*- encoding : utf-8 -*-
class Group::School < Group::Group
  has_one :address, :class_name => 'Address', as: :owner

  def init()
    super
    self.can_delete_member << Group::Roles::ADMIN
    self.can_write_file << Group::Roles::MEMBER
    self.can_delete_file << Group::Roles::ADMIN
    self.can_delete_status << Group::Roles::ADMIN
    self.can_manage_invitations << Group::Role::ADMIN
  end

end
