# -*- encoding : utf-8 -*-
class CreateFolders < ActiveRecord::Migration
  def change
    create_table :c_file_folders do |t|
      t.belongs_to :c_file
      t.belongs_to :structure
      t.timestamps
    end
  end
end
