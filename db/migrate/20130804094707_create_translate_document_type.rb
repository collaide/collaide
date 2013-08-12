# -*- encoding : utf-8 -*-
class CreateTranslateDocumentType < ActiveRecord::Migration
  def up
    Document::Type.create_translation_table!({
        name: :string,
        description: :text
                                           })
  end

  def down
    Document::Type.drop_translation_table!
  end
end
