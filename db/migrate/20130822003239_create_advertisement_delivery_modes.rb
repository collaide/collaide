# -*- encoding : utf-8 -*-
class CreateAdvertisementDeliveryModes < ActiveRecord::Migration
  def change
    create_table :advertisement_delivery_modes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
