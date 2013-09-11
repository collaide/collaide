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
  attr_accessible :currency, :price, :payment_modes, :delivery_modes

  extend Enumerize
  enumerize :currency, in: [:EUR, :CHF, :USD]
  serialize :payment_modes, Array
  enumerize :payment_modes, in: [:cash, :bank, :check], multiple: true
  serialize :delivery_modes, Array
  enumerize :delivery_modes, in: [:hand, :post], multiple: true

  validates_presence_of :price, :numericality => {
      :greater_than => 0,
      :less_than_or_equal_to => 10000
  }
  validates_presence_of :currency
end
