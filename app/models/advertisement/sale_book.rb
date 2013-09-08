# -*- encoding : utf-8 -*-
class Advertisement::SaleBook < Advertisement::Sale
  attr_accessible :state, :annotation, :domain_ids

  extend Enumerize
  enumerize :annotation, in: [:not_annotated, :slightly_annotated, :annotated, :very_annotated]
  enumerize :state, in: [:new, :like_new, :normal, :damaged, :very_damaged]

  #Liaisons
  belongs_to :book
  has_and_belongs_to_many :domains, order: 'position ASC'

  accepts_nested_attributes_for :domains
  accepts_nested_attributes_for :book

end