# -*- encoding : utf-8 -*-
class CreateCFileOwners < ActiveRecord::Migration
  def change
    create_table :c_file_owners do |t|
      t.string :name
      t.integer :rights

      t.timestamps
    end
  end
end
