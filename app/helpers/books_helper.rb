# -*- encoding : utf-8 -*-
module BooksHelper
  def parse_isbn(isbn)
    isbn.gsub!('-','')
    isbn.gsub!('.','')
    isbn.gsub!('_','')
    isbn.gsub!(' ','')
  end

  def book_image(book)
    if book.image_link
      image_tag book.image_link
    else
      image_tag 'annonces/no_cover_thumb.gif'
    end
  end

end