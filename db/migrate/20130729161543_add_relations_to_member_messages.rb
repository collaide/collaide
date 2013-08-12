# -*- encoding : utf-8 -*-
class AddRelationsToMemberMessages < ActiveRecord::Migration
  def change
    add_column :member_messages, :user_id, :integer
    add_column :member_messages, :message_id, :integer
  end
end
