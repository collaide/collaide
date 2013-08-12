# -*- encoding : utf-8 -*-
class AddUserIdToContact < ActiveRecord::Migration
  def change
    add_column :member_contacts, :user_id, :integer
    add_index :member_contacts, :user_id
  end
end
