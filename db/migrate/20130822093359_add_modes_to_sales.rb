class AddModesToSales < ActiveRecord::Migration
  def change
    # C'est dans advertisements, car il y a l'héritage
    add_column :advertisement_advertisements, :payment_mode_id, :int
    add_column :advertisement_advertisements, :delivery_mode_id, :int
  end
end
