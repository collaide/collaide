ThinkingSphinx::Index.define 'advertisement/sale_book', with: :active_record do
  indexes book(:title), as: :book_title # index le titre du livre appartenant à l'annonce
  indexes book(:isbn_10), as: :isbn_10
  indexes book(:isbn_13), as: :isbn_13
  has created_at, updated_at, book_id
end
