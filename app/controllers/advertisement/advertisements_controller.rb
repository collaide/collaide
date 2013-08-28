class Advertisement::AdvertisementsController < ApplicationController
  def test
    @books = GoogleBooks.search('The Great Gatsby')
    #@first_book = books.first


    #first_book.author #=> 'F. Scott Fitzgerald'
    #first_book.isbn #=> '9781443411080'
    #first_book.image_link(:zoom => 6) #=> 'http://bks2.books.google.com/books?id=...'
  end
end
