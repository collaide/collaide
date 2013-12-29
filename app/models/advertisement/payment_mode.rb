# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: advertisement_payment_modes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# -*- encoding : utf-8 -*-
class Advertisement::PaymentMode < ActiveRecord::Base
  attr_accessible :description, :name

  #traduction
  translates :name, :description, fallbacks_for_empty_translations: true
  #FIXME: le fallback ne marche pas. En fait si, de temps en temps...
  Globalize.fallbacks = {:en => [:en, :fr], :fr => [:fr, :en]}

  has_and_belongs_to_many :sales, :class_name => 'Advertisement::Sale'

  validates_presence_of :name
end
