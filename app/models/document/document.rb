class Document::Document < ActiveRecord::Base
  attr_accessible :author, :description, :language, :number_of_pages, :realized_at, :title, :study_level_id,
                  :document_type_id, :user_id

  has_many :files, :class_name => 'CFile::CFile'
  belongs_to :study_level, :class_name => 'Document::StudyLevel'
  belongs_to :document_type, :class_name => 'Document::Type'
  has_and_belongs_to_many :domains
  belongs_to :user

  validates :author, presence: true, length: {minimum: 3, maximum: 30}
  validates :description, presence: true, length: {minimum: 5}
  validates_presence_of :language
  validates :number_of_pages, numericality: true, inclusion: {in: 1..100}
  validates :realized_at, date: {before: Proc.new {Time.now}}
  validates :title, presence: true, length: {minimum: 3, maximum: 30}, uniqueness: true
end
