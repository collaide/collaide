# -*- encoding : utf-8 -*-
class Contact < ActiveRecord::Base

  #attr_accessor :subject, :email, :content

  validates :subject, presence: true
  validates :email, presence: true
  validates :content, presence: true
end
