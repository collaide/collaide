# == Schema Information
#
# Table name: c_file_structures
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  size             :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  member_group_id  :integer
#  c_file_c_file_id :integer
#  ancestry         :string(255)
#  position         :integer
#

# -*- encoding : utf-8 -*-
class CFile::Structure < ActiveRecord::Base
  attr_accessible :name, :size, :group_id, :files_attributes, :files_ids, :user_id

  #Liaison one to many
  belongs_to :user
  belongs_to :group, :class_name => 'Member::Group::Group'

  #Liaison many to one
  has_many :c_file_folders, :class_name => 'CFile::Folder'
  has_many :files, class_name: 'CFile::CFile', through: :c_file_folders, source: :c_file

  #Liaison many to many
  #has_and_belongs_to_many

  has_paper_trail

  has_ancestry :orphan_strategy => :rootify

  accepts_nested_attributes_for :files

  validates_presence_of :name
end
