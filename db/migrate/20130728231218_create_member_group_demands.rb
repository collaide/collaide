# -*- encoding : utf-8 -*-
class CreateMemberGroupDemands < ActiveRecord::Migration
  def change
    create_table :member_group_demands do |t|
      t.text :message

      t.timestamps
    end
  end
end
