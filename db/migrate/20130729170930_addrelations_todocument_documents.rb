class AddrelationsTodocumentDocuments < ActiveRecord::Migration
  def change
    add_column :document_documents, :study_level_id, :integer
    add_column :document_documents, :document_type_id, :integer
    add_column :document_documents, :user_id, :integer
  end
end
