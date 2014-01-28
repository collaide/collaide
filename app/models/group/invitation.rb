# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: group_demands
#
#  id         :integer          not null, primary key
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  group_id   :integer
#

# -*- encoding : utf-8 -*-
class Group::Invitation < ActiveRecord::Base

  extend Enumerize
  enumerize :status, in: [:accepted, :pending, :later, :refused], default: :pending, predicates: true

  enumerize :role, in: [Group::Roles::ADMIN,
                        Group::Roles::WRITER,
                        Group::Roles::MEMBER,
                        Group::Roles::ALL], default: Group::Roles::MEMBER

  scope :pending, -> { where(status: :pending) }
  scope :later, -> { where(status: :later) }


  # Who sent the invitation
  belongs_to :sender, polymorphic: true

  belongs_to :group, :class_name => 'Group::Group'

  belongs_to :receiver, polymorphic: true

  # The receiver is added to the group
  def accept
    self.status = :accepted
    self.group.add_members(self.receiver, self.role, :was_invited, self.sender)
    self.save
  end

  def decline
    self.status = :refused
    self.save
  end

  def chose_later
    self.status = :later
    self.save
  end
end
