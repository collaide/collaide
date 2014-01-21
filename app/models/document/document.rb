# -*- encoding : utf-8 -*-
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
#  status           :string(255)      default("refused")
#  hits             :integer
#  is_deleted       :boolean          default(FALSE)
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
class Document::Document < ActiveRecord::Base
  extend Enumerize

  enumerize :status, in: [:accepted, :pending, :refused], default: :pending, predicates: true

  #permte aux utilisateurs de commenter un document. https://github.com/jackdempsey/acts_as_commentable
  acts_as_commentable

  SORT_ARGS = {title: 'title', lang: 'language', author: 'author', created_at: 'created_at', type: 'document_types.name',
               domain: 'domain.name', study_level: 'document_study_levels.name', domain: 'domains.name'}
  # permet de donner une note à un document. voir : https://github.com/muratguzel/letsrate
  letsrate_rateable 'note'

  scope :valid, -> { where(status: :accepted) }

  has_many :files, :class_name => 'CFile::CFile', dependent: :delete_all
  has_many :document_downloads, :class_name => 'Document::Download'
  has_many :user_downloader, :class_name => 'User', through: :document_downloads, source: :user

  belongs_to :study_level, :class_name => 'Document::StudyLevel', include: :translations
  belongs_to :document_type, :class_name => 'Document::Type', include: :translations

  has_and_belongs_to_many :domains, order: 'position ASC'

  belongs_to :user

  has_one :note_average, :as => :cacheable, :class_name => "RatingCache", :dependent => :destroy, :conditions => {:dimension => 'note'}


  accepts_nested_attributes_for :files
  accepts_nested_attributes_for :domains

  before_validation :add_author
  before_save :check_is_accepted

  #validation du type de fichier
  #création d'une image en fonction du fichier
  validates :author, presence: true, length: {minimum: 3, maximum: 30}
  validates :description, presence: true, length: {minimum: 5}
  validates_presence_of :language
  validates_presence_of :domains
  validates_presence_of :study_level
  validates_presence_of :document_type
  validates_presence_of :files
  validates :number_of_pages, numericality: true, inclusion: {in: 1..300}
  #TODO conversion du format de la date en format de type SQL (YYY-mm-dd)
  validates :realized_at, date: {before: Proc.new {Time.now}}
  validates :title, presence: true, length: {minimum: 3, maximum: 60}

  def show_extension
    I18n.t("application_name.#{Document::DocumentsController.helpers.find_extension(files.first.file_content_type)}")
  end

  private

    def check_is_accepted
      unless is_accepted?
        if accepted? and Document::Document.find(id).pending?
          self.is_accepted = true
        end
      end
    end

    def add_author
      self.author = user.to_s if author.blank?
    end
end
