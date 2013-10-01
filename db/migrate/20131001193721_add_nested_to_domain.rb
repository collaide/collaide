class AddNestedToDomain < ActiveRecord::Migration
  def change
    add_column :domains, :lft, :integer
    add_column :domains, :rgt, :integer
    add_column :domains, :depth, :integer
    add_column :domains, :parent_id, :integer
    #rename_column :domains, :ancestry, :parent_id
  end
end
