class AddRelationsToMemberStatuses < ActiveRecord::Migration
  def change
    add_column :member_statuses, :user_id, :integer
    add_column :member_statuses, :member_group_id, :integer
  end
end
