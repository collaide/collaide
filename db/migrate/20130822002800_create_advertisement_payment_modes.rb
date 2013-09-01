# -*- encoding : utf-8 -*-
class CreateAdvertisementPaymentModes < ActiveRecord::Migration
  def change
    create_table :advertisement_payment_modes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
