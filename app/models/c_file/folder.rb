class CFile::Folder < ActiveRecord::Base

  belongs_to :file, :class_name => 'CFile::CFile'
  belongs_to :structure, :class_name => 'CFile::Structure'
end
