# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: addresses
#
#  id            :integer          not null, primary key
#  country       :string(255)
#  street        :string(255)
#  street_number :integer
#  city_code     :integer
#  country_code  :string(255)
#  is_actual     :boolean          default(TRUE)
#  created_at    :datetime
#  updated_at    :datetime
#

# -*- encoding : utf-8 -*-
class Address < ActiveRecord::Base

  #has_and_belongs_to_many :users
  belongs_to :owner, polymorphic: true
end
