# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: user_messages
#
#  id      :integer          not null, primary key
#  body    :text
#  subject :string(255)
#

class UserMessage
  include ActiveModel::Model
  include ActiveModel::Validations

  #validates_with UserMessageValidator

  validates_presence_of :body
  #validates_presence_of :subject
  validates_presence_of :user_ids
  #
 # has_many :users

  attr_accessor :user_ids, :body, :subject, :users

  def initialize(params = {})
    super(params)
    @users = []
  end

  def user_ids_form
    @users.map do |user|
      user.id
    end.join(', ')
  end
    #before_validation :default_title

end
