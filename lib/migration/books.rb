def fill_book(book, google_book)
  # mettre à jour book
  book.title = google_book.title
  book.description = google_book.description
  book.average_rating = google_book.average_rating
  book.ratings_count = google_book.ratings_count
  book.isbn_10 = google_book.isbn_10
  book.isbn_13 = google_book.isbn_13
  if (authors = google_book.authors).present?
    book.authors = authors
  else
    book.authors = 'Auteur inconnu'
  end
  book.language = google_book.language
  book.page_count = google_book.page_count
  # si c'est juste 2000, j'ajoute 2000-01-01
  if google_book.published_date.length == 4
    book.published_date = "#{google_book.published_date}-01-01".to_date
  else
    book.published_date = google_book.published_date
  end
  book.publisher = google_book.publisher
  book.image_link = google_book.image_link

=begin
      if google_book.image_link(:zoom => 2)
        book.image_link = google_book.image_link(:zoom => 2)
      elsif google_book.image_link(:zoom => 5)
        book.image_link = google_book.image_link(:zoom => 5)
      elsif google_book.image_link(:zoom => 1)
        book.image_link = google_book.image_link(:zoom => 1)
      else
        book.image_link = google_book.image_link(:zoom => 4)
      end
=end
  book.preview_link = google_book.preview_link
  book.info_link = google_book.info_link
  return book
end

OldCollaide.instance.client.query('SELECT * FROM bookinfo').each do |book|
  next if Book.find_by(isbn_13: book['book_isbn']) || Book.find_by(isbn_10: book['book_isbn'])
  g_book = GoogleBooks.search("isbn:#{book['book_isbn']}").first
  if g_book
    c_book = Book.find_by(isbn_13: g_book.isbn_13) || Book.find_by(isbn_10: g_book.isbn_10) || Book.new(isbn_13: g_book.isbn_13, isbn_10: g_book.isbn_10)
    begin
      fill_book(c_book, g_book).save!
    rescue Exception => e
      puts "'#{c_book.title}' not saved #{e}"
      next
    end
    #puts "#{book.title} created"
  else
    puts "'#{book['book_title']}' wit isbn '#{book['book_isbn']}' not found"
  end
  sleep(30.seconds)
end