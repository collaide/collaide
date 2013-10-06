# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)
#  role_mask              :integer
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  points                 :integer          default(5)
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :registerable

   attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :avatar, :name, :points,
                   :last_sign_in_at, :created_at

  #https://github.com/ging/mailboxer
  acts_as_messageable

  has_one :contact, :class_name => 'Member::Contact', inverse_of: :user
  has_one :parameter, :class_name => 'Member::Parameter'
  has_one :repository, :class_name => 'CFile::Structure'

  has_many :documents, :class_name => 'Document::Document'
  has_many :document_downloads, :class_name => 'Document::Download'
  has_many :downloads, class_name: 'Document::Document', through: :document_downloads, source: :document

  has_many :statues, :class_name => 'Member::Status', inverse_of: :user
  has_many :scolarities, :class_name => 'Member::Scolarity'

  has_many :group_members, :class_name => 'Member::Group::Member'
  has_many :groups, :class_name => 'Member::Group::Group', through: :group_members, source: :member_group
  has_many :created_group_demands, :class_name => 'Member::Group::Demand'

  has_many :member_friend_friends, :class_name => 'Member::Friend::Friend'
  has_many :friends, :class_name => 'Member::Friend::Friend', through: :member_friend_friends, source: :user
  has_many :created_friend_demands, :class_name => 'Member::Friend::Demand', foreign_key: :user_has_sent_id
  has_many :friend_demands, class_name: 'Member::Friend::Demand', foreign_key: :user_is_invited_id

  has_and_belongs_to_many :group_demands, :class_name => 'Member::Group::Demand', join_table: 'group_demands_users'
  has_and_belongs_to_many :addresses, :class_name => 'Member::Address', join_table: 'member_addresses_users'

  has_many :advertisements, :class_name => 'Advertisement::Advertisement'

  #paperclip https://github.com/thoughtbot/paperclip
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "users/no-avatar.png"

  # permet à un utilisateur de donner une note à un document. voir : https://github.com/muratguzel/letsrate
  letsrate_rater

  validates :name, presence: true

  #https://github.com/alexreisner/geocoder
  geocoded_by :current_sign_in_ip   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  validate :points, numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true
  }

  # Plus d'infos : https://github.com/ryanb/cancan/wiki/Role-Based-Authorization
  #ne pas modifier, ajouter
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

  #Returning the email address of the model if an email should be sent for this object (Message or Notification).
  #If no mail has to be sent, return nil.
  def mailboxer_email(object)
    #Check if an email should be sent for that object
    #if true
    self.email
    #if false
    #return nil
  end

  def name_to_show
    self.name
  end

end

class Point
  DOWNLOAD_DOCUMENT = 3
end
