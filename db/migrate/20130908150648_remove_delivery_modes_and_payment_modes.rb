class RemoveDeliveryModesAndPaymentModes < ActiveRecord::Migration
  def change
    drop_table :advertisement_delivery_mode_translations
    drop_table :advertisement_delivery_modes
    drop_table :advertisement_payment_mode_translations
    drop_table :advertisement_payment_modes

    add_column :advertisement_advertisements, :delivery_modes, :string
    add_column :advertisement_advertisements, :payment_modes, :string
  end
end
