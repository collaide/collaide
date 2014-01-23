# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: User_addresses
#
#  id            :integer          not null, primary key
#  country       :string(255)
#  street        :string(255)
#  street_number :integer
#  city_code     :integer
#  country_code  :string(255)
#  is_actual     :boolean          default(TRUE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# -*- encoding : utf-8 -*-
class User::Address < ActiveRecord::Base
  attr_accessible :city_code, :country, :country_code, :is_actual, :street, :street_number

  #has_and_belongs_to_many :users
  belongs_to :owner, polymorphic: true
end
