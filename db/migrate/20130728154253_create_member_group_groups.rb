# -*- encoding : utf-8 -*-
class CreateMemberGroupGroups < ActiveRecord::Migration
  def change
    create_table :member_group_groups do |t|
      t.string :name
      t.text :description
      t.boolean :is_public, default: true
      t.string :password

      t.timestamps
    end
  end
end
