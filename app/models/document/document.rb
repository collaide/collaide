# == Schema Information
#
# Table name: document_documents
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :text
#  author           :string(255)
#  number_of_pages  :integer          default(1)
#  realized_at      :date
#  language         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  study_level_id   :integer
#  document_type_id :integer
#  user_id          :integer
#

# -*- encoding : utf-8 -*-
class Document::Document < ActiveRecord::Base

  SORT_ARGS = {title: 'title', lang: 'language', author: 'author', created_at: 'created_at', type: 'document_types.name',
               domain: 'domain.name', study_level: 'document_study_levels.name', domain: 'domains.name'}

  attr_accessible :author, :description, :language, :number_of_pages, :realized_at, :title, :study_level_id,
                  :document_type_id, :user_id, :files_attributes, :domains_attributes, :domain_ids

  has_many :files, :class_name => 'CFile::CFile', dependent: :delete_all
  belongs_to :study_level, :class_name => 'Document::StudyLevel', include: :translations
  belongs_to :document_type, :class_name => 'Document::Type', include: :translations
  has_and_belongs_to_many :domains, order: 'position ASC'
  belongs_to :user


  accepts_nested_attributes_for :files
  accepts_nested_attributes_for :domains
  #validation du type de fichier
  #création d'une image en fonction du fichier
  validates :author, presence: true, length: {minimum: 3, maximum: 30}
  validates :description, presence: true, length: {minimum: 5}
  validates_presence_of :language
  validates_presence_of :domains
  validates_presence_of :study_level
  validates_presence_of :document_type
  validates_presence_of :files
  validates :number_of_pages, numericality: true, inclusion: {in: 1..100}
  #TODO conversion du format de la date en format de type SQL (YYY-mm-dd)
  validates :realized_at, date: {before: Proc.new {Time.now}}
  validates :title, presence: true, length: {minimum: 3, maximum: 30}, uniqueness: true
end
