# -*- encoding : utf-8 -*-
class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name
      t.text :description
      t.string :ancestry

      t.timestamps
    end
  end
end
