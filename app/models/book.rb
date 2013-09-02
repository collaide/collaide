class Book < ActiveRecord::Base
  attr_accessible :authors, :average_rating, :description, :image_link, :info_link, :isbn_10, :isbn_13, :language, :page_count, :preview_link, :published_date, :publisher, :ratings_count, :title

  has_many :sale_books, :class_name => 'Advertisement::SaleBook'

  # permet de donner une note à un document. voir : https://github.com/muratguzel/letsrate
  letsrate_rateable 'note'

end
