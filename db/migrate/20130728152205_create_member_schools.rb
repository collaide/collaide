class CreateMemberSchools < ActiveRecord::Migration
  def change
    create_table :member_schools do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
