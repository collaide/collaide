class ChangeUsersModels3 < ActiveRecord::Migration
  def change
    rename_table :group_members, :group_group_members
  end
end
