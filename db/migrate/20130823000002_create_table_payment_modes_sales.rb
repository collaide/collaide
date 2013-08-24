class CreateTablePaymentModesSales < ActiveRecord::Migration
  def change
    create_table :payment_modes_sales do |t|
      t.belongs_to :payment_mode
      t.belongs_to :sale
    end
  end
end