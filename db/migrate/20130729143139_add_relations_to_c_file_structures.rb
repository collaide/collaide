# -*- encoding : utf-8 -*-
class AddRelationsToCFileStructures < ActiveRecord::Migration
  def change
    add_column :c_file_structures, :user_id, :integer
    add_column :c_file_structures, :member_group_id, :integer
    add_column :c_file_structures, :c_file_c_file_id, :integer
    add_index :c_file_structures, :user_id
    add_index :c_file_structures, :member_group_id
  end
end
