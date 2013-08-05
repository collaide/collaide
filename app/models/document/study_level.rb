class Document::StudyLevel < ActiveRecord::Base
  attr_accessible :description, :name, :translations_attributes

  has_many :documents, :class_name => 'Document::Document'

  translates :name, :description

  validates_presence_of :name
  validates_presence_of :description

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
