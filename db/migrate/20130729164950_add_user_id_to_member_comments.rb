class AddUserIdToMemberComments < ActiveRecord::Migration
  def change
    add_column :member_comments, :user_id, :integer
    add_index :member_comments, :user_id
  end
end
