# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: advertisement_advertisements
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  description    :text
#  active         :boolean
#  type           :string(255)
#  user_id        :integer
#  book_id        :integer
#  language       :string(255)
#  hits           :integer
#  price          :decimal(9, 2)
#  currency       :string(255)
#  delivery_modes :string(255)
#  payment_modes  :string(255)
#  state          :string(255)
#  annotation     :string(255)
#  study_level    :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

# -*- encoding : utf-8 -*-
class Advertisement::Sale < Advertisement::Advertisement
  extend Enumerize
  enumerize :currency, in: [:EUR, :CHF, :USD]
  serialize :payment_modes, Array
  enumerize :payment_modes, in: [:cash, :bank, :check], multiple: true
  serialize :delivery_modes, Array
  enumerize :delivery_modes, in: [:hand, :post], multiple: true

  validates :price, presence: true, :numericality => {
      :greater_than_or_equal_to => 0,
      :less_than_or_equal_to => 10000
  }
  validates_presence_of :currency
end
