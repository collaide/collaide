# -*- encoding : utf-8 -*-
class AddRelationsToMemberScolarities < ActiveRecord::Migration
  def change
    add_column :member_scolarities, :user_id, :integer
    add_column :member_scolarities, :member_school_id, :integer
  end
end
