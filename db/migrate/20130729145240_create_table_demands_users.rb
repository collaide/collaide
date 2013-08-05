class CreateTableDemandsUsers < ActiveRecord::Migration
  def up
    create_table :demands_users do |t|
      t.belongs_to :demand
      t.belongs_to :user
    end
  end

  def down
    drop_table :demands_users
  end
end
