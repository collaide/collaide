# -*- encoding : utf-8 -*-
class Advertisement::Sale < Advertisement::Advertisement
  attr_accessible :currency, :price, :payment_modes, :delivery_modes

  extend Enumerize
  enumerize :currency, in: [:EUR, :CHF, :USD], default: :EUR, predicates: true
  enumerize :payment_modes, in: [:cash, :bank, :check], multiple: true, predicates: true
  enumerize :delivery_modes, in: [:hand, :post], multiple: true, predicates: true

  #has_and_belongs_to_many :payment_modes, :class_name => 'Advertisement::PaymentMode', include: :translations
  #has_and_belongs_to_many :delivery_modes, :class_name => 'Advertisement::DeliveryMode', include: :translations

  #accepts_nested_attributes_for :payment_modes
  #accepts_nested_attributes_for :delivery_modes


  validates_presence_of :price, numericality: true, inclusion: {in: 0..300}
  validates_presence_of :currency
end
