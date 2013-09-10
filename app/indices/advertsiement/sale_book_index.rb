ThinkingSphinx::Index.define 'advertisement/sale_book', with: :active_record do
  indexes title, sortable: true
  indexes description
  #TODO: add other search fields
  has created_at, updated_at
end