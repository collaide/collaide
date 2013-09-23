class FixProblemsDocuments < ActiveRecord::Migration
  def change
    change_column :document_documents, :hits, :integer, default: 0
    change_column :document_documents, :status, :string, default: 'pending'
    remove_index :document_documents, :title
  end
end
