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

class Contact < ActiveRecord::Base

  #attr_accessor :subject, :email, :content

  validates :subject, presence: true
  validates :email, presence: true
  validates :content, presence: true
end
