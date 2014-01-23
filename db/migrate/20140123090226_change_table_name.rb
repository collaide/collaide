class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :user_statues, :user_statuses
  end
end
