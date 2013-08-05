class CreateFolders < ActiveRecord::Migration
  def change
    create_table :c_file_folders do |t|
      t.belongs_to :file
      t.belongs_to :structure
      t.timestamps
    end
  end
end
