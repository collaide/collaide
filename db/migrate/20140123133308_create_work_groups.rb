class CreateWorkGroups < ActiveRecord::Migration
  def change
    create_table :work_groups do |t|

      t.timestamps
    end
  end
end
