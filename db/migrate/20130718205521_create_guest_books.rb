# -*- encoding : utf-8 -*-
class CreateGuestBooks < ActiveRecord::Migration
  def change
    create_table :guest_books do |t|
      t.string :name
      t.text :comment

      t.timestamps
    end
  end
end
