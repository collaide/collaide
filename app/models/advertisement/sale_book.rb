# -*- encoding : utf-8 -*-
class Advertisement::SaleBook < Advertisement::Sale
  attr_accessible :state, :annotation, :book_attributes, :domain_ids

  extend Enumerize
  enumerize :annotation, in: %w[no_annotation annotations], default: 'no_annotation', predicates: true
  enumerize :state, in: %w[new like_new old], default: 'new', predicates: true

  #Liaisons
  belongs_to :book
  has_and_belongs_to_many :domains, order: 'position ASC'

  accepts_nested_attributes_for :domains
  accepts_nested_attributes_for :book

end
