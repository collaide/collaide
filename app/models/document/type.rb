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

  has_many :documents, :class_name => 'Document::Document'

  translates :name, :description

  validates_presence_of :description
  validates_presence_of :name

  accepts_nested_attributes_for :translations

  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
    set_translations new_translations
  end

  class Translation
    attr_accessible :locale, :name, :description
  end
end
