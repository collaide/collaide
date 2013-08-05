class CreateCFileCFiles < ActiveRecord::Migration
  def change
    create_table :c_file_c_files do |t|
      t.integer :rights

      t.timestamps
    end
  end
end
