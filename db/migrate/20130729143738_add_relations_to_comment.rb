class AddRelationsToComment < ActiveRecord::Migration
  def change
    add_column :member_comments, :member_status_id, :integer
  end
end
