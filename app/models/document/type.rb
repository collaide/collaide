# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: document_types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# -*- encoding : utf-8 -*-
class Document::Type < ActiveRecord::Base

  has_many :documents, :class_name => 'Document::Document', foreign_key: :document_type_id

  translates :name, :description

  validates_presence_of :description
  validates_presence_of :name

  accepts_nested_attributes_for :translations

end
