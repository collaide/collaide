# -*- encoding : utf-8 -*-
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


  has_many :sale_books, :class_name => 'Advertisement::SaleBook'
  accepts_nested_attributes_for :sale_books

  # permet de donner une note à un document. voir : https://github.com/muratguzel/letsrate
  letsrate_rateable 'note'
  has_one :note_average, -> {where :dimension => 'note'}, :as => :cacheable, :class_name => "RatingCache", :dependent => :destroy
  validates_presence_of :title
  validates_presence_of :authors
  #validate :has_a_valid_isbn

  def has_a_valid_isbn
    unless isbn_13.blank?
      google_book = GoogleBooks.search("isbn:#{isbn_13}").first
      unless google_book
        errors.add(:isbn_13, "#{I18n.t('sale_books.new.forms.valid_isbn')}. #{I18n.t('sale_books.new.forms.other_solution')}")
      end
    end
  end
end
