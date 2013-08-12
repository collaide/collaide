# -*- encoding : utf-8 -*-
class CreateMemberAddresses < ActiveRecord::Migration
  def change
    create_table :member_addresses do |t|
      t.string :country
      t.string :street
      t.integer :street_number
      t.integer :city_code
      t.string :country_code
      t.boolean :is_actual, default: true

      t.timestamps
    end
  end
end
