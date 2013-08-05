class AddDocumentIdToCFileCFiles < ActiveRecord::Migration
  def change
    add_column :c_file_c_files, :document_id, :integer
  end
end
