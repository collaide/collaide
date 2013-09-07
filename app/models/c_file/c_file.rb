# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: c_file_c_files
#
#  id                :integer          not null, primary key
#  rights            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  document_id       :integer
#  bit_mask          :integer
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#

# -*- encoding : utf-8 -*-
class CFile::CFile < ActiveRecord::Base
  attr_accessible :rights, :file, :position

  belongs_to :creator, class_name: 'User'
  belongs_to :document, :class_name => 'Document::Document'

   has_many :c_file_folders, :class_name => 'CFile::Folder'
  has_many :structures, :class_name => 'CFile::Structure', through: :c_file_folders

  has_attached_file :file,
                    url: ':filename',
                    path: ':rails_root/download/:class/:attachment/:id_partition/:style/:filename'

  has_paper_trail
  RIGHTS = %w[read write execute]
  has_bit_mask :rights, RIGHTS
end
