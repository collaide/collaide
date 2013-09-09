# -*- encoding : utf-8 -*-
class Advertisement::Sale < Advertisement::Advertisement
  attr_accessible :currency, :price, :payment_modes, :delivery_modes

  extend Enumerize
  enumerize :currency, in: [:EUR, :CHF, :USD], default: :EUR
  serialize :payment_modes, Array
  enumerize :payment_modes, in: [:cash, :bank, :check], multiple: true
  serialize :delivery_modes, Array
  enumerize :delivery_modes, in: [:hand, :post], multiple: true

  validates_presence_of :price, numericality: {greater_than: 0}
  validates_presence_of :currency
end
