# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)
#  role                   :string(255)
#  avatar                 :string(255)
#  points                 :integer          default(5)
#  has_notifications      :boolean          default(FALSE)
#  provider               :string(255)
#  uid                    :string(255)
#  latitude               :float
#  longitude              :float
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-


class   User < ActiveRecord::Base
  extend Enumerize

  mount_uploader :avatar, UserUploader
  # For connexion via FB and others
  #devise :omniauthable, :omniauth_providers => [:facebook, :google]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable, :omniauthable

  enumerize :role, in: [:admin, :moderator, :author, :banned, :super_admin, :doc_validator, :add_validator], scope: true, predicates: true

  #https://github.com/ging/mailboxer
  acts_as_messageable
  #
  has_repository

  #has_one :contact, :class_name => 'User::Contact', inverse_of: :user
  #has_one :parameter, :class_name => 'User::Parameter'

  has_many :documents, :class_name => 'Document::Document'
  # Quels documents sont téléchargés
  has_many :document_downloads, :class_name => 'Document::Download'
  has_many :downloads, class_name: 'Document::Document', through: :document_downloads, source: :document
#------

  # Status de l'utilisateur sur son mur
  #has_many :statues, :class_name => 'User::Status', inverse_of: :user

  # Un user a plusieurs études (gymnase, uni, etc) chaque études à une établissement scolaire, une période et une orientation
  #has_many :studies, :class_name => 'User::Study'

  #many-to-many
  #has_many :user_friend_friends, :class_name => 'User::Friend::Friend'
  #has_many :friends, :class_name => 'User::Friend::Friend', through: :user_friend_friends, source: :user
  #####
  #demande envoyée
 # has_many :created_friend_demands, :class_name => 'User::Friend::Demand', foreign_key: :user_has_sent_id
  #demande reçues
  #has_many :friend_demands, class_name: 'User::Friend::Demand', foreign_key: :user_is_invited_id

  has_many :notifications, class_name: 'AppNotification', as: :owner

  # Invitation pour les groupes
  has_many :sent_group_invitations, class_name: 'Group::Invitation', as: 'sender'
  has_many :received_group_invitations, class_name: 'Group::Invitation', as: 'receiver'
  # Un user a plusieurs groupes et un groupe a plusieurs utilisateurs
  has_many :group_members, as: :member, :class_name => 'Group::GroupMember'
  has_many :groups, :class_name => 'Group::Group', through: :group_members#, source: :group

  #has_and_belongs_to_many :addresses, :class_name => 'User::Address', join_table: 'user_addresses_users'

  has_many :advertisements, :class_name => 'Advertisement::Advertisement'

  #paperclip https://github.com/thoughtbot/paperclip
  #has_attached_file :avatar,
  #                  :styles => { :medium => "300x300>", :thumb => "100x100>" },
  #                  :default_url => "users/no-avatar.png"

  # permet à un utilisateur de donner une note à un document. voir : https://github.com/muratguzel/letsrate
  letsrate_rater
  scope :search_by_email_or_name, -> (term) { where('email LIKE :email or name LIKE :name', email: "%#{term}%", name: "%#{term}%").limit 10 }

  def self.search_for_autocomplete(term)
    self.search_by_email_or_name(term)
  end
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

  # Renvoi le nom de l'utilisateur
  def to_s
    self.name
  end

  # Essaie de donner un nom unique à l'utilisateur, basé sur l'adresse, mail
  def to_single_name
    self.name+" (#{self.email[0 ]}...@#{self.email.split('@').last.to_s})"
  end


  # Envoie une invitation a rejoindre le group aux receivers
  def send_group_invitations(group, receivers, message = '')
    group.send_invitations(receivers, message, self)
  end

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      avatar = process_avatar(auth.info.image)
      user.remote_avatar_url = avatar if avatar # assuming the user model has an image
      user.save!
    end
  end

  def self.find_for_google_oauth2(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      avatar = process_avatar(auth.info.image)
      user.remote_avatar_url = avatar if avatar # assuming the user model has an image
      user.save!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.process_avatar(uri)
    response = Net::HTTP.get_response(URI(uri))
    case response
      when Net::HTTPSuccess then
        return uri
      when Net::HTTPRedirection then
        return response['location']
      else
        return false
    end
  end

  #has_many :authorizations
  #
  #def self.new_with_session(params,session)
  #  if session["devise.user_attributes"]
  #    new(session["devise.user_attributes"],without_protection: true) do |user|
  #      user.attributes = params
  #      user.valid?
  #    end
  #  else
  #    super
  #  end
  #end
  #
  #def self.from_omniauth(auth, current_user)
  #  authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
  #  if authorization.user.blank?
  #    user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
  #    if user.blank?
  #      user = User.new
  #      user.password = Devise.friendly_token[0,10]
  #      user.name = auth.info.name
  #      user.email = auth.info.email
  #      auth.provider == "twitter" ?  user.save(:validate => false) :  user.save
  #    end
  #    authorization.username = auth.info.nickname
  #    authorization.user_id = user.id
  #    authorization.save
  #  end
  #  authorization.user
  #end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
end

class Point
  DOWNLOAD_DOCUMENT = 3
end
