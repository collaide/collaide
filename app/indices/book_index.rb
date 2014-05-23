# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define 'book', with: :active_record do
  indexes title, sortable: true
  indexes description
  indexes authors
  indexes isbn_10
  indexes isbn_13

  has created_at, updated_at
end
