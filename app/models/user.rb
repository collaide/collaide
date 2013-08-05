class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :registerable

   attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :avatar, :name

  has_one :contact, :class_name => 'Member::Contact', inverse_of: :user
  has_one :parameter, :class_name => 'Member::Parameter'
  has_one :repository, :class_name => 'CFile::Structure'

  has_many :documents, :class_name => 'Document::Document'

  has_many :statuses, :class_name => 'Member::Status', inverse_of: :user
  has_many :scolarities, :class_name => 'Member::Scolarity'

  has_many :group_members, :class_name => 'Member::Group::Member'
  has_many :groups, :class_name => 'Member::Group::Group', through: :group_members, source: :member_group
  has_many :create_group_demands, :class_name => 'Member::Group::Demand'

  has_many :member_friend_friends, :class_name => 'Member::Friend::Friend'
  has_many :friends, :class_name => 'Member::Friend::Friend', through: :member_friend_friends, source: :user
  has_many :created_friend_demands, :class_name => 'Member::Friend::Demand', foreign_key: :user_has_sent_id
  has_many :friend_demands, class_name: 'Member::Friend::Demand', foreign_key: :user_is_invited_id

  has_many :messages_send, :class_name => 'Member::Message'
  has_many :member_message_inboxes, :class_name => 'Member::Message::Inbox'
  has_many :messages_received, :class_name => 'Member::Message::Inbox', through: :member_message_inboxes, source: :message

  has_and_belongs_to_many :group_demands, :class_name => 'Member::Group::Demand', join_table: 'group_demands_users'
  has_and_belongs_to_many :addresses, :class_name => 'Member::Address', join_table: 'member_addresses_users'

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "rails.png"

  validates :name, presence: true

  ROLES = %w[admin moderator author banned super-admin]

  def roles=(roles)
    self.role_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((role_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def zero?
      no_roles?
  end

  def is?(role)
    self.roles.each do |r|
      return true if r == role
    end
    false
  end

  def no_roles?
    role_mask.nil?
  end
end
