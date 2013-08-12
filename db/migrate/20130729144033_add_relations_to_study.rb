# -*- encoding : utf-8 -*-
class AddRelationsToStudy < ActiveRecord::Migration
  def change
    add_column :member_studies, :member_scolarity_id, :integer
    add_index :member_studies, :member_scolarity_id
  end
end
