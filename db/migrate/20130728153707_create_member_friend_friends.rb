# -*- encoding : utf-8 -*-
class CreateMemberFriendFriends < ActiveRecord::Migration
  def change
    create_table :member_friend_friends do |t|

      t.timestamps
    end
  end
end
