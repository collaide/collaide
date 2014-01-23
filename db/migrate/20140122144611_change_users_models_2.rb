class ChangeUsersModels2 < ActiveRecord::Migration
  def change
    rename_table :group_users, :group_members
  end
end
