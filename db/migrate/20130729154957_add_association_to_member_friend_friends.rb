class AddAssociationToMemberFriendFriends < ActiveRecord::Migration
  def change
    add_column :member_friend_friends, :user_id, :integer
  end
end
