# -*- encoding : utf-8 -*-
class CreateDocumentDocuments < ActiveRecord::Migration
  def change
    create_table :document_documents do |t|
      t.string :title
      t.text :description
      t.string :author
      t.integer :number_of_pages, default: 1
      t.date :realized_at
      t.string :language

      t.timestamps
    end
  end
end
