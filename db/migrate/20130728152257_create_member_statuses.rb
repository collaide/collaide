# -*- encoding : utf-8 -*-
class CreateMemberStatuses < ActiveRecord::Migration
  def change
    create_table :member_statuses do |t|
      t.text :message2

      t.timestamps
    end
  end
end
