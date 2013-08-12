# -*- encoding : utf-8 -*-
class CreateMemberContacts < ActiveRecord::Migration
  def change
    create_table :member_contacts do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :gender

      t.timestamps
    end
  end
end
