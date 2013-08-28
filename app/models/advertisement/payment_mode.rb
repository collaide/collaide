class Advertisement::PaymentMode < ActiveRecord::Base
  attr_accessible :description, :name

  #traduction
  translates :name, :description, fallbacks_for_empty_translations: true
  #FIXME: le fallback ne marche pas. En fait si, de temps en temps...
  Globalize.fallbacks = {:en => [:en, :fr], :fr => [:fr, :en]}

  has_and_belongs_to_many :sales, :class_name => 'Advertisement::Sale'

end
