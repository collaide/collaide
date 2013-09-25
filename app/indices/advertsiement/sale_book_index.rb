ThinkingSphinx::Index.define 'advertisement/sale_book', with: :active_record do
  indexes book(:title), as: :book_title # index le titre du livre appartenant à l'annonce

  has created_at, updated_at, book_id
end