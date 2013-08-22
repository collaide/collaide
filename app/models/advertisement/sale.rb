class Advertisement::Sale < Advertisement::Advertisement
  attr_accessible :currency, :price

  belongs_to :payment_mode, :class_name => 'Advertisement::PaymentMode', include: :translations
  belongs_to :delivery_mode, :class_name => 'Advertisement::DeliveryMode', include: :translations
end
