class CreateAdvertisementAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisement_advertisements do |t|
      t.string :title
      t.text :description
      t.boolean :active
      t.string :type
      # pour sale (héritée de advertissement)
      t.decimal :price
      t.string :currency
      # pour sale_book (héritée de sale)
      t.integer :state
      t.integer :annotation

      t.timestamps
    end
  end
end
