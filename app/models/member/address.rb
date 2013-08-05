class Member::Address < ActiveRecord::Base
  attr_accessible :city_code, :country, :country_code, :is_actual, :street, :street_number

  has_and_belongs_to_many :users

end
