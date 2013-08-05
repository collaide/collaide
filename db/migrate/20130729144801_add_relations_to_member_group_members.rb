class AddRelationsToMemberGroupMembers < ActiveRecord::Migration
  def change
    add_column :member_group_members, :user_id, :integer
    add_column :member_group_members, :member_group_id, :integer
  end
end
