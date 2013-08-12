# -*- encoding : utf-8 -*-
class AddAncestryToCFileStructure < ActiveRecord::Migration
  def change
    add_column :c_file_structures, :ancestry, :string
    add_index :c_file_structures, :ancestry
  end
end
