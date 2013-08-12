# -*- encoding : utf-8 -*-
class AddRelationsToMemberGroupDemands < ActiveRecord::Migration
  def change
    add_column :member_group_demands, :user_id, :integer
    add_column :member_group_demands, :group_id, :integer
  end
end
