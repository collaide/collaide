class CreateDocumentStudyLevels < ActiveRecord::Migration
  def change
    create_table :document_study_levels do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
