# -*- encoding : utf-8 -*-
class CreateTableDeliveryModesSales < ActiveRecord::Migration
  def change
    create_table :delivery_modes_sales do |t|
      t.belongs_to :delivery_mode
      t.belongs_to :sale
    end
  end
end
