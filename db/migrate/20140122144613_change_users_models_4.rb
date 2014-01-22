class ChangeUsersModels4 < ActiveRecord::Migration
  def change
    add_column :user_studies, :user_id, :integer
  end
end
