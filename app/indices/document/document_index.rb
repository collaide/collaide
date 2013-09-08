ThinkingSphinx::Index.define 'document/document', with: :active_record do
  indexes title, sortable: true
  indexes description
  indexes author
  #TODO: add stopwords
  has created_at, updated_at
end