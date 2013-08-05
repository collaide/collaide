class AddRelationsToMemberFriendDemand < ActiveRecord::Migration
  def change
    add_column :member_friend_demands, :user_has_sent_id, :integer
    add_column :member_friend_demands, :user_is_invited_id, :integer
  end
end
