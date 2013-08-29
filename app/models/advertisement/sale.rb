class Advertisement::Sale < Advertisement::Advertisement
  attr_accessible :currency, :price

  has_and_belongs_to_many :payment_modes, :class_name => 'Advertisement::PaymentMode', include: :translations
  has_and_belongs_to_many :delivery_modes, :class_name => 'Advertisement::DeliveryMode', include: :translations

  validates_presence_of :price, numericality: true, inclusion: {in: 0..300}
  validates_presence_of :currency
end
