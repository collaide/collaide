class CFile::CFile < ActiveRecord::Base
  attr_accessible :rights, :file

  belongs_to :creator, class_name: 'User'
  belongs_to :document, :class_name => 'Document::Document'

   has_many :c_file_folders, :class_name => 'CFile::Folder'
  has_many :structures, :class_name => 'CFile::Structure', through: :c_file_folders

  has_attached_file :file

  has_paper_trail

  has_bit_mask :rights, %w[read write execute]
end
