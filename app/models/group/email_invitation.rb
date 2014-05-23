# == Schema Information
#
# Table name: group_email_invitations
#
#  id             :integer          not null, primary key
#  email          :string(255)
#  message        :text
#  secret_token   :string(255)
#  status         :string(255)
#  group_group_id :integer
#  user_id        :integer
#

class Group::EmailInvitation < ActiveRecord::Base
  extend Enumerize
  enumerize :status, in: [:accepted, :pending, :later, :refused], default: :pending, predicates: true

  scope :give_a_reply, -> { where("group_email_invitations.status='later' OR group_email_invitations.status='pending'") }

  belongs_to :group_group, :class_name => 'Group::Group'
  belongs_to :user
end
