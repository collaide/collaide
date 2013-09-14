# -*- encoding : utf-8 -*-
module Advertisement::SaleBooksHelper
  def sale_book_title(sale_book)
    unless sale_book.title.blank?
      sale_book.title
    else
      t'sale_books.show.sale_title',  book: sale_book.book.title
    end
  end
end
