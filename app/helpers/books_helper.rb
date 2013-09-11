# -*- encoding : utf-8 -*-
module BooksHelper
  def parseIsbn(isbn)
    isbn.gsub!('-','')
    isbn.gsub!('.','')
    isbn.gsub!('_','')
    isbn.gsub!(' ','')
  end
end
