# -*- encoding : utf-8 -*-
class Advertisement::SaleBook < Advertisement::Sale
  attr_accessible :state, :annotation, :domain_ids

  has_and_belongs_to_many :domains, order: 'position ASC'

  validates :state, numericality: true, inclusion: {in: 0..6}
  validates :annotation, numericality: true, inclusion: {in: 0..5}
end
