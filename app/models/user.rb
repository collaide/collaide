# -*- encoding : utf-8 -*-
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
class   User < ActiveRecord::Base
  extend Enumerize

  # For connexion via FB and others
  devise :omniauthable, :omniauth_providers => [:facebook, :google]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :registerable

  attr_accessible :provider, :uid, :email, :password, :password_confirmation, :remember_me, :roles, :avatar, :name, :points,
                   :last_sign_in_at, :created_at, :has_notifications
  enumerize :role, in: [:admin, :moderator, :author, :banned, :super_admin, :doc_validator, :add_validator], scope: true, predicates: true

  #https://github.com/ging/mailboxer
  acts_as_messageable

  has_repository

  has_one :contact, :class_name => 'Member::Contact', inverse_of: :user
  has_one :parameter, :class_name => 'Member::Parameter'

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

  has_many :notifications, class_name: 'UserNotification'

  has_and_belongs_to_many :group_demands, :class_name => 'Member::Group::Demand', join_table: 'group_demands_users'
  has_and_belongs_to_many :addresses, :class_name => 'Member::Address', join_table: 'member_addresses_users'

  has_many :advertisements, :class_name => 'Advertisement::Advertisement'

  #paperclip https://github.com/thoughtbot/paperclip
  has_attached_file :avatar,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "users/no-avatar.png"

  # permet à un utilisateur de donner une note à un document. voir : https://github.com/muratguzel/letsrate
  letsrate_rater

  validates :name, presence: true

  #https://github.com/alexreisner/geocoder
  geocoded_by :current_sign_in_ip   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  validates :points, numericality: {
      only_integer: true
  }

  #Returning the email address of the model if an email should be sent for this object (Message or Notification).
  #If no mail has to be sent, return nil.
  def mailboxer_email(object)
    #Check if an email should be sent for that object
    #if true
    self.email
    #if false
    #return nil
  end

  def to_s
    self.name
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
      )
    end
    user
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(name: data["name"],
                         email: data["email"],
                         password: Devise.friendly_token[0,20]
      )
    end
    user
  end

end

class Point
  DOWNLOAD_DOCUMENT = 3
end
