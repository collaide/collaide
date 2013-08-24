class Advertisement::DeliveryMode < ActiveRecord::Base
  attr_accessible :description, :name

  #traduction
  translates :name, :description, fallbacks_for_empty_translations: true
  #FIXME: le fallback ne marche pas. En fait si, de temps en temps...
  Globalize.fallbacks = {:en => [:en, :fr], :fr => [:fr, :en]}

  has_many :sales, :class_name => 'Advertisement::Sale'

  validates_presence_of :name

  #accepts_nested_attributes_for :translations

  #def translations_attributes=(attributes)
  #  new_translations = attributes.values.reduce({}) do |new_values, translation|
  #    new_values.merge! translation.delete("locale") => translation
  #  end
  #  set_translations new_translations
  #end
  #
  #class Translation
  #  attr_accessible :locale, :name, :description
  #end

end
