# -*- encoding : utf-8 -*-
class CreateMemberParameters < ActiveRecord::Migration
  def change
    create_table :member_parameters do |t|
      t.string :language
      t.string :localization

      t.timestamps
    end
  end
end
