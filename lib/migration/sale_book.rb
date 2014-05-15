OldCollaide.instance.client.query('SELECT * FROM bookstock').each do |sale|
  sale_book = Advertisement::SaleBook.new(
      old_id: sale['vente_id'].to_i,
      price: sale['vente_price'],
      currency: sale['vente_devise'].to_sym,
      description: sale['vente_description'],
  )
  case sale['vente_etat'].to_i
    when 1
      sale_book.state = :new
    when 2
      sale_book.state = :like_new
    when 3
      sale_book.state = :normal
    when 4
      sale_book.state = :damaged
    when 5
      sale_book.state = :very_damaged
  end
  case sale['vente_annot'].to_i
    when 1
      sale_book.annotation = :not_annotated
    when 2
      sale_book.annotation = :slightly_annotated
    when 3
      sale_book.annotation = :annotated
  end
  sale_book.active = (sale['vente_on'].to_i == 0 ? false : true)
  user = OldCollaide.instance.client.query("SELECT * FROM membres WHERE mem_ID='#{sale['vente_mem']}'").first
  sale_book.user = User.find_by name: user['mem_pseudo']
  book = OldCollaide.instance.client.query("SELECT * FROM bookinfo WHERE book_id='#{sale['vente_book']}'").first
  sale_book.book = Book.find_by isbn_13: book['book_isbn']
  if sale_book.book.nil?
    puts "Could not find th book(#{book['book_isbn']}) for sale #{sale['vente_id']}"
    next
  end
  sale['vente_payement'].split(',').each do |mode|
    case mode
      when 'Espèces'
        sale_book.payment_modes << :cash
      when 'Virement'
        sale_book.payment_modes << :bank
    end
  end
  sale['vente_livraison'].split('').each do |mode|
    case mode
      when 'Remise en main propre'
        sale_book.delivery_modes << :hand
      when 'Envoie par la poste'
        sale_book.delivery_modes << :post
    end
  end
  sale_book.title = "A vendre : #{sale_book.book.title}"
  sale_book.save!
  sale_book.created_at = Time.at(sale['vente_date'].to_i)
  sale_book.save!
  #puts "'#{sale_book.title}' created."
  #1 aucune annotation

end