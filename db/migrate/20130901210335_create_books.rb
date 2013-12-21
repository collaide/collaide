# -*- encoding : utf-8 -*-
class CreateBooks < ActiveRecord::Migration
  def change
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
  end
end
