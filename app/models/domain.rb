# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: domains
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  ancestry    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  position    :integer
#

# -*- encoding : utf-8 -*-
class Domain < ActiveRecord::Base
  has_paper_trail

  has_ancestry :orphan_strategy => :rootify

  #acts_as_nested_set

  translates :name, :description, fallbacks_for_empty_translations: true
  #FIXME: le fallback ne marche pas. En fait si, de temps en temps...
  Globalize.fallbacks = {:en => [:en, :fr], :fr => [:fr, :en]}

  has_and_belongs_to_many :documents, :class_name => 'Document::Document'
  has_and_belongs_to_many :saleBooks, :class_name => 'Advertisement::SaleBook'

  accepts_nested_attributes_for :translations

  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
    set_translations new_translations
  end

  def self.json_tree(nodes)
    nodes.map do |node, sub_nodes|
      json = {}
      json[:label] = node.name
      json[:id] = node.id
      json[:children] =  json_tree(sub_nodes).compact
      json
    end
  end

  def self.select_tree(separator='----')
    tree(Domain.includes(:translations).arrange(order: :position), separator)
  end

  def self.flat(nodes)
    name = ""
    nodes.map.with_index do |a_domain, key|
      separator = ', '
      separator = " #{I18n.translate('dico.and')} " if nodes.size >=2 and key+2 == nodes.size
      name += "#{a_domain.name}#{separator}"
    end
    name.chop.chop
  end

  private
    def self.tree(domains, separator, result=[])
      domains.each do |node, sub_nodes|
        unless node.name.nil?
          node.name = separator*node.depth + node.name
          result << node
          tree(sub_nodes, separator, result)
        end
      end
      return result
    end

  class Translation
  end
end
