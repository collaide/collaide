class AddPositionToCFileStructures < ActiveRecord::Migration
  def change
    add_column :c_file_structures, :position, :integer
  end
end
