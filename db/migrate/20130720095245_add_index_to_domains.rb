# -*- encoding : utf-8 -*-
class AddIndexToDomains < ActiveRecord::Migration
  def change
    add_index :domains, :ancestry
  end
end
