# -*- encoding : utf-8 -*-
class CreateMemberComments < ActiveRecord::Migration
  def change
    create_table :member_comments do |t|
      t.text :message

      t.timestamps
    end
  end
end
