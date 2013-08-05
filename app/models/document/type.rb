class Document::Type < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :documents, :class_name => 'Document::Document'

  translates :name, :description

  validates_presence_of :description
  validates_presence_of :name
end
