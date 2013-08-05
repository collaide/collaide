class AddAttachmentToCFileCFile < ActiveRecord::Migration
  def self.up
    add_attachment :c_file_c_files, :file
  end

  def self.down
    remove_attachment :c_file_c_files, :file
  end
end
