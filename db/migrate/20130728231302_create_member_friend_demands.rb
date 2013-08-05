class CreateMemberFriendDemands < ActiveRecord::Migration
  def change
    create_table :member_friend_demands do |t|
      t.text :message

      t.timestamps
    end
  end
end
