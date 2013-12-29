# -*- encoding : utf-8 -*-
class ChangeColumnsPriceToAdvertisementAdvertisements < ActiveRecord::Migration
  def change
    # pour sale_book (héritée de sale)
    change_column :advertisement_advertisements, :price, :decimal, :precision => 9, :scale => 2
  end
end
