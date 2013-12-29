# -*- encoding : utf-8 -*-
class Contact < ActiveRecord::Base
  attr_accessible :content, :email, :subject

  validates :subject, presence: true
  validates :email, presence: true
  validates :content, presence: true
end
