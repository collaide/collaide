class AddFieldsToDocument < ActiveRecord::Migration
  def change
    add_column :document_documents, :status, :string, default: 'refused'
    add_column :document_documents, :hits, :integer
    add_column :document_documents, :is_deleted, :boolean, default: false
  end
end
