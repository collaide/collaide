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
#  can_read_status        :string(255)
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

# -*- encoding : utf-8 -*-
class Group::Group < ActiveRecord::Base

  include Concerns::ActivityConcern


  ROLES = [:admin, :writer]

  has_repository

  serialize :can_index_activity, Array

  serialize :can_delete_group, Array

  serialize :can_index_members, Array
  serialize :can_read_member, Array
  serialize :can_delete_member, Array

  serialize :can_write_file, Array
  serialize :can_index_files, Array
  serialize :can_read_file, Array
  serialize :can_delete_file, Array

  serialize :can_index_statuses, Array
  serialize :can_read_status, Array
  serialize :can_write_status, Array
  serialize :can_delete_status, Array

  serialize :can_create_invitation, Array
  serialize :can_manage_invitations, Array

  belongs_to :user
  belongs_to :main_group, class_name: 'Group::Group'
  has_many :sub_groups, class_name: 'Group::Group', foreign_key: "main_group_id"
  has_many :statuses, class_name: 'Status', as: :owner
  has_many :group_members, class_name: 'Group::GroupMember'

  # Renvoi les membres user et group
  has_many :u_members, through: :group_members, source: :member, source_type: 'User'
  has_many :g_members, through: :group_members, source: :member, source_type: 'Group'

  has_many :sent_group_invitations, class_name: 'Group::Invitation', as: 'sender'
  has_many :group_invitations, class_name: 'Group::Invitation'
  # A mettre dans User aussi
  has_many :received_group_invitations, class_name: 'Group::Invitation', as: 'receiver'

  has_many :email_invitations, foreign_key: 'group_group_id'

  def p_or_l_group_invitations
    self.group_invitations.give_a_reply
  end

  def p_or_l_email_invitations
    self.email_invitations.give_a_reply
  end

  ##################################################
  # POUR AFFICHER TOUT LES MEMBRES (group et user ensemble) ##############
  ################################################

  # returns all members
  def members
    self.u_members + self.g_members
  end

  #attr_accessor :members
  #
  #scope :participant, lambda {|participant|
  #  select('DISTINCT mailboxer_conversations.*').
  #      where('mailboxer_notifications.type'=> Mailboxer::Message.name).
  #      order("mailboxer_conversations.updated_at DESC").
  #      joins(:receipts).merge(Mailboxer::Receipt.recipient(participant))
  #}
  #
  #scope :recipient, lambda { |recipient|
  #  where(:receiver_id => recipient.id,:receiver_type => recipient.class.base_class.to_s)
  #}
  #
  #
  #scope :member, lambda { |member|
  #  joins(:group_members).where('group_group_members.member_id' => member.id,'group_group_members.member_type' => member.class.base_class.to_s)
  #}

  ##################################################
  # FIN ##############
  ################################################

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
    self.can_delete_group << Group::Roles::ADMIN
  end

  # send an invitation to the receivers
  def send_invitations(receivers, message: '', sender: self, receiver_type: 'User')
    if receivers.kind_of?(Array)
      receivers.each do |r|
        invitation = Group::Invitation.new(message: message)
        invitation.sender = sender
        if r.is_a? Fixnum or r.is_a? String
          invitation.receiver_id = r.to_i
          invitation.receiver_type = receiver_type
          #create_activity(:create, trackable: invitation, owner_id: r.to_i, owner_type: receiver_type)
        else
          invitation.receiver = r
          #create_activity(:create, trackable: invitation, recipient: r, owner: sender)
        end
        self.group_invitations << invitation
      end
    elsif receivers.is_a? Group::DoInvitation
      do_invitation receivers, sender: sender, receiver_type: receiver_type
      # TODO demander à Numa comment récupérer les infos
    else
      invitation = Group::Invitation.new(message: message)
      invitation.sender = sender
      invitation.receiver = receivers

      #create_activity(:create, trackable: invitation, recipient: receivers, owner: sender)

      self.group_invitations << invitation
    end
  end

  # Ajoute un membre au groupe avec le role, la méthode et le user qui l'a ajouté ou invité
  # On ne peux pas ajouter deux fois le même membre.
  def add_members(members, role: Group::Roles::MEMBER, joined_method: :by_itself, invited_or_added_by: nil)
    if members.kind_of?(Array)
      members.each do |m|
        unless Group::GroupMember.where(group: self, member: m).take
          gm = Group::GroupMember.new
          gm.member = m
          gm.role = role
          gm.joined_method = joined_method
          gm.invited_or_added_by = invited_or_added_by
          self.group_members << gm
          self.save
          create_activity(:joined, trackable: self, owner: m)
        end
      end
    else
      if Group::GroupMember.get_a_member members, self
        return false
      end
      gm = Group::GroupMember.new
      gm.member = members
      gm.role = role
      gm.joined_method = joined_method
      gm.invited_or_added_by = invited_or_added_by
      self.group_members << gm
      self.save
      create_activity(:joined, trackable: self, owner: members)
    end
  end

  def to_s
    self.name
  end

  def can?(can_action, can_type, actor)
    member_actor = (actor.is_a?(Group::GroupMember) ? actor : Group::GroupMember.get_a_member(actor, self))
    if member_actor.nil?
      can_do(can_action, can_type).empty?
    elsif member_actor.role.to_sym == :admin
      true
    elsif member_actor.role.to_sym == :all and can_do(can_action, can_type).empty?
      true
    else
      can_do(can_action, can_type).include?(member_actor.role.to_sym)
    end
  end

  private
    def can_do(action, type)
      self.send("can_#{action.to_s}_#{type.to_s}")
    end

    def do_invitation(do_invitation, sender: self, receiver_type: 'User')
      do_invitation.users_id.each do |an_id|
        next if an_id.to_i < 1 or !an_id.to_i.is_a? Fixnum
        invitation  = Group::Invitation.new message: do_invitation.message,  receiver_type: receiver_type, receiver_id: an_id, sender: sender
        self.group_invitations << invitation
      end
      do_invitation.email_list.split(', ').each do |an_email|
        if an_email =~ Group::DoInvitationValidator::VALID_EMAIL_REGEX
          a_user = User.find_by email: an_email
          if a_user
            invitation  = Group::Invitation.new message: do_invitation.message,  receiver_type: receiver_type, receiver_id: a_user.id, sender: sender
            self.group_invitations << invitation
          else
            ei = Group::EmailInvitation.create(
                email: an_email, message: do_invitation.message, group_group: self, user: sender, secret_token: SecureRandom.hex(16)
            )
            GroupMailer.new_invitation(ei).deliver
            ei.save
          end
        end
      end
    end

end

class Group::Roles
  ALL = :all
  ADMIN = :admin
  WRITER = :writer
  MEMBER = :member
end
