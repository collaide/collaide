class CreateDocumentDownloads < ActiveRecord::Migration
  def change
    create_table :document_downloads do |t|
      t.belongs_to :user
      t.belongs_to :document_documents
      t.integer :number_of_downloads
      t.timestamps
    end
  end
end
