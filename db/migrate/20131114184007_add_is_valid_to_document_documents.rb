# -*- encoding : utf-8 -*-
class AddIsValidToDocumentDocuments < ActiveRecord::Migration
  def change
    add_column :document_documents, :is_accepted, :boolean, default: false
  end
end
