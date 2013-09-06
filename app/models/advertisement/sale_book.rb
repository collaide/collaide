# -*- encoding : utf-8 -*-
class Advertisement::SaleBook < Advertisement::Sale
  attr_accessible :state, :annotation, :domain_ids

  extend Enumerize
  enumerize :annotation, in: %w[no_annotation annotations], predicates: true
  enumerize :state, in: %w[new like_new old], predicates: true

  #Liaisons
  belongs_to :book
  has_and_belongs_to_many :domains, order: 'position ASC'

  accepts_nested_attributes_for :domains
  accepts_nested_attributes_for :book

end