# -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define 'document/document', with: :active_record do
  indexes title, sortable: true
  indexes description
  indexes author
  indexes user(:name), as: :user
  indexes document_type.translations.name, as: :document_type
  indexes study_level
  indexes domains.translations.name, as: :domains

  where "
  document_type_translations.locale='fr' and
  domain_translations.locale='fr'
"
  #TODO: add stopwords
  has created_at, updated_at, user_id, document_type_id
  has domains(:id), as: :domain_ids
end
