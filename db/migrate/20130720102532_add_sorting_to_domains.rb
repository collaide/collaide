# -*- encoding : utf-8 -*-
class AddSortingToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :position, :integer
  end
end
