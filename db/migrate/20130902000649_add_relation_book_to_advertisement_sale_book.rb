# -*- encoding : utf-8 -*-
class AddRelationBookToAdvertisementSaleBook < ActiveRecord::Migration
  def change
    add_column :advertisement_advertisements, :book_id, :integer
  end
end
