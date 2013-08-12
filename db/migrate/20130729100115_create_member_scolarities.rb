# -*- encoding : utf-8 -*-
class CreateMemberScolarities < ActiveRecord::Migration
  def change
    create_table :member_scolarities do |t|

      t.timestamps
    end
  end
end
