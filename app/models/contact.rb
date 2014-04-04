# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  email      :string(255)
#  content    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Contact
  include ActiveModel::Model
  include ActiveModel::Validations

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :subject, :email, :content

  validates :subject, presence: true
  validates :email, presence: true
  validates :content, presence: true
  validate :has_valid_email


  def has_valid_email
    unless self.email =~ VALID_EMAIL_REGEX
      errors.add(:email, "#{I18n.t('static_pages.contact.form.no_valid_email')}")
    end
  end
end
