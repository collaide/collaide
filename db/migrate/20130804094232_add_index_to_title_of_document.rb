# -*- encoding : utf-8 -*-
class AddIndexToTitleOfDocument < ActiveRecord::Migration
  def change
    add_index :document_documents, :title
  end
end
