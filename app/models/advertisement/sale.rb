class Advertisement::Sale < Advertisement::Advertisement
  attr_accessible :currency, :price

  #TODO : Relation many to many
  has_and_belongs_to_many :payment_modes, :class_name => 'Advertisement::PaymentMode', include: :translations
  has_and_belongs_to_many :delivery_modes, :class_name => 'Advertisement::DeliveryMode', include: :translations
end
