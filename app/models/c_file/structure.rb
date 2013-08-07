class CFile::Structure < ActiveRecord::Base
  attr_accessible :name, :size, :group_id, :files_attributes

  belongs_to :user
  belongs_to :group, :class_name => 'Member::Group::Group'

  has_many :c_file_folders, :class_name => 'CFile::Folder'
  has_many :files, class_name: 'CFile::CFile', through: :c_file_folders

  has_paper_trail

  has_ancestry :orphan_strategy => :rootify

  accepts_nested_attributes_for :files

  validates_presence_of :name
end
