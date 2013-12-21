# -*- encoding : utf-8 -*-
class UserMessage < ActiveRecord::Base
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  attr_accessible :subject, :body, :user_ids

  column :subject, :string
  column :body, :text

  validates_presence_of :body
  #validates_presence_of :subject
  validates_presence_of :users

  has_and_belongs_to_many :users
end
