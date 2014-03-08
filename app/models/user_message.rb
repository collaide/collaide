# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: user_messages
#
#  id      :integer          not null, primary key
#  body    :text
#  subject :string(255)
#

class UserMessage < ActiveRecord::Base

  validates_presence_of :body
  validates_presence_of :subject
  validates_presence_of :users

  has_and_belongs_to_many :users

  before_validation :default_title

  private
  def default_title
    self.subject = I18n.t('messages.default.title') if subject.blank?
  end
end
