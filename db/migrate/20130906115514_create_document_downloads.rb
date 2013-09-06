class CreateDocumentDownloads < ActiveRecord::Migration
  def change
    create_table :document_downloads do |t|
      t.belongs_to :user
      t.belongs_to :document_documents
      t.timestamps
    end
  end
end
