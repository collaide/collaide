# == Schema Information
#
# Table name: c_file_folders
#
#  id           :integer          not null, primary key
#  c_file_id    :integer
#  structure_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
class CFile::Folder < ActiveRecord::Base

  belongs_to :c_file, :class_name => 'CFile::CFile'
  belongs_to :structure, :class_name => 'CFile::Structure'
end
