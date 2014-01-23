# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: group_groups
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# -*- encoding : utf-8 -*-
class Group::School < Group::Group
  has_one :address, :class_name => 'Address', as: :owner

  after_initialize :init

  def init()
    self.can_delete_member << Group::Roles::ADMIN
    self.can_write_file << Group::Roles::MEMBER
    self.can_delete_file << Group::Roles::ADMIN
    self.can_delete_status << Group::Roles::ADMIN
    self.can_manage_invitations << Group::Role::ADMIN
  end

end
