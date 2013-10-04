class ChangeFieldsOfTableUsers < ActiveRecord::Migration
  def up
    remove_column :users, :role_mask
    add_column :users, :role, :string
  end

  def down
    add_column :users, :role_mask, :string
    remove_column :users, :role
  end
end
