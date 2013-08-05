class Domain < ActiveRecord::Base
  attr_accessible :description, :name, :position, :translations_attributes

  has_paper_trail

  has_ancestry :orphan_strategy => :rootify

  translates :name, :description

  has_and_belongs_to_many :documents, :class_name => 'Document::Document'

  accepts_nested_attributes_for :translations

  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
    set_translations new_translations
  end

  def self.json_tree(nodes)
    nodes.map do |node, sub_nodes|
      {label: node.name, id: node.id, children: json_tree(sub_nodes).compact}
    end
  end

  class Translation
    attr_accessible :locale, :name, :description
  end
end
