class CreateTranslateDocumentStudyLevel < ActiveRecord::Migration
  def up
    Document::StudyLevel.create_translation_table!({
        name: :string,
        description: :text
                                                   })
  end

  def down
    Document::StudyLevel.drop_translation_table!
  end
end
