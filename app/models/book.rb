# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  attr_accessible :authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title

  has_many :sale_books, :class_name => 'Advertisement::SaleBook'

  # permet de donner une note à un document. voir : https://github.com/muratguzel/letsrate
  letsrate_rateable 'note'

  validates_presence_of :title
  validate :has_a_valid_isbn

  def has_a_valid_isbn
    google_book = GoogleBooks.search("isbn:#{isbn_13}").first
    unless google_book
      errors.add(:isbn_13, I18n.t('sale_books.new.forms.valid_isbn'))
    end
  end

end
