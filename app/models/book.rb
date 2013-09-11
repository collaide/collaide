# == Schema Information
#
# Table name: books
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  authors        :string(255)
#  publisher      :string(255)
#  published_date :date
#  description    :text
#  isbn_10        :string(255)
#  isbn_13        :string(255)
#  page_count     :integer
#  average_rating :float
#  ratings_count  :integer
#  language       :string(255)
#  preview_link   :string(255)
#  info_link      :string(255)
#  image_link     :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base

  attr_accessible :authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title


  has_many :sale_books, :class_name => 'Advertisement::SaleBook'
  accepts_nested_attributes_for :sale_books

  # permet de donner une note à un document. voir : https://github.com/muratguzel/letsrate
  letsrate_rateable 'note'

  validates_presence_of :title
  validates_presence_of :isbn_13
  validate :has_a_valid_isbn

  def has_a_valid_isbn
    unless isbn_13.blank?
      google_book = GoogleBooks.search("isbn:#{isbn_13}").first
      unless google_book
        errors.add(:isbn_13, I18n.t('sale_books.new.forms.valid_isbn'))
      end
    end
  end

end
