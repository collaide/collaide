class CreateDocumentTypes < ActiveRecord::Migration
  def change
    create_table :document_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
