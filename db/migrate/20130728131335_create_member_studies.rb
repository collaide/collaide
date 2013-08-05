class CreateMemberStudies < ActiveRecord::Migration
  def change
    create_table :member_studies do |t|
      t.date :started_at
      t.date :ended_at
      t.string :orientation
      t.timestamps
    end
  end
end
