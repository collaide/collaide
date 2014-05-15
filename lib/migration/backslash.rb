def remove_backslahe(field)
  field.gsub(/\\{1}/, '') if field
end

Book.all.each do |a_book|
  remove_backslahe a_book.description
  a_book.save
end

Document::Document.all.each do |doc|
  doc.title = remove_backslahe doc.title
  doc.description = remove_backslahe doc.description
  doc.author = remove_backslahe doc.author
  doc.save
end

Document::Type.all.each { |type| type.name = remove_backslahe type.name; type.save }

Domain.all.each do |dom|
  dom.name = remove_backslahe dom.name
  dom.save
end

Advertisement::SaleBook.all.each do |book|
  book.description = remove_backslahe book.description
  book.save
end