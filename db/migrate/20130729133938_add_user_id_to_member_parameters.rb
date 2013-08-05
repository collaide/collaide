class AddUserIdToMemberParameters < ActiveRecord::Migration
  def change
    add_column :member_parameters, :user_id, :integer
    add_index :member_parameters, :user_id
  end
end
