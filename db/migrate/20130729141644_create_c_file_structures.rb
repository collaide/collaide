# -*- encoding : utf-8 -*-
class CreateCFileStructures < ActiveRecord::Migration
  def change
    create_table :c_file_structures do |t|
      t.string :name
      t.integer :size

      t.timestamps
    end
  end
end
