# == Schema Information
#
# Table name: advertisement_advertisements
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  active      :boolean
#  type        :string(255)
#  price       :decimal(9, 2)
#  currency    :string(255)
#  state       :string(255)
#  annotation  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  language    :string(255)
#  book_id     :integer
#  hits        :integer          default(0)
#

# -*- encoding : utf-8 -*-
class Advertisement::Sale < Advertisement::Advertisement
  attr_accessible :currency, :price, :payment_mode_ids, :delivery_mode_ids

  extend Enumerize
  enumerize :currency, in: %w[EUR CHF DOL], default: 'EUR', predicates: true

  has_and_belongs_to_many :payment_modes, :class_name => 'Advertisement::PaymentMode', include: :translations
  has_and_belongs_to_many :delivery_modes, :class_name => 'Advertisement::DeliveryMode', include: :translations

  accepts_nested_attributes_for :payment_modes
  accepts_nested_attributes_for :delivery_modes


  validates_presence_of :price, numericality: true, inclusion: {in: 0..300}
end
