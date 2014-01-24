class CreateTableAdvertisement < ActiveRecord::Migration
  def change
    create_table :advertisement_advertisements do |t|
      t.string :title
      t.text :description
      t.boolean :active
      t.string :type
      t.belongs_to :user, index: true
      t.belongs_to :book_id, index: true
      t.string :language
      t.integer :hits

      # pour sale (héritée de advertissement)
      t.decimal :price, :precision => 9, :scale => 2
      t.string :currency
      t.string :delivery_modes
      t.string :payment_modes

      # pour sale_book (héritée de sale)
      t.string :state
      t.string :annotation

      t.belongs_to :study_level, index:true

      t.timestamps
    end

    create_join_table :domains, :advertisement_advertisements

    create_table :books do |t|
      t.string :title
      t.string :authors
      t.string :publisher
      t.date :published_date
      t.text :description
      t.string :isbn_10
      t.string :isbn_13
      t.integer :page_count
      t.float :average_rating
      t.integer :ratings_count
      t.string :language
      t.string :preview_link
      t.string :info_link
      t.string :image_link

      t.timestamps
    end

    create_table :rating_caches do |t|
      t.belongs_to :cacheable, :polymorphic => true
      t.float :avg, :null => false
      t.integer :qty, :null => false
      t.string :dimension
      t.timestamps
    end

    add_index :rating_caches, [:cacheable_id, :cacheable_type]

    create_table :rates do |t|
      t.belongs_to :rater
      t.belongs_to :rateable, :polymorphic => true
      t.float :stars, :null => false
      t.string :dimension
      t.timestamps
    end

    add_index :rates, :rater_id
    add_index :rates, [:rateable_id, :rateable_type]
  end
end
