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

  # Who sent the invitation
  belongs_to :sender, polymorphic: true

  belongs_to :group, :class_name => 'Group::Group'

  has_many :propositions, :class_name => 'Group::InvitationProposition'

  has_many :receivers, :through => :propositions

  #has_and_belongs_to_many :receivers
  #
  #scope :receivers, lambda { |receiver|
  #  joins(:group_invitations_receivers).where('group_invitations_receivers.member_id' => receiver.id,'group_invitations_receivers.member_type' => receiver.class.base_class.to_s)
  #}
end
