# -*- encoding : utf-8 -*-
class Contact < ActiveRecord::Base
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  attr_accessible :content, :email, :subject

  column :subject, :string
  column :email, :string
  column :content, :text

  validates :subject, presence: true
  validates :email, presence: true
  validates :content, presence: true
end
