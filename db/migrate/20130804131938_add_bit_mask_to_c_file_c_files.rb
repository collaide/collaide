# -*- encoding : utf-8 -*-
class AddBitMaskToCFileCFiles < ActiveRecord::Migration
  def change
    add_column :c_file_c_files, :bit_mask, :integer
  end
end
