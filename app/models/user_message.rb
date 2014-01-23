# -*- encoding : utf-8 -*-
class UserMessage < ActiveRecord::Base

  validates_presence_of :body
  #validates_presence_of :subject
  validates_presence_of :users

  has_and_belongs_to_many :users
end
