# -*- encoding : utf-8 -*-
class ChangeColumnsToAdvertisementAdvertisements < ActiveRecord::Migration
  def change
    # pour sale_book (héritée de sale)
    change_column :advertisement_advertisements, :state, :string
    change_column :advertisement_advertisements, :annotation, :string
  end
end
