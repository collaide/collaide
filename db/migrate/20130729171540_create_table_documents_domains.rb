# -*- encoding : utf-8 -*-
class CreateTableDocumentsDomains < ActiveRecord::Migration
  def up
    create_table :documents_domains do |t|
      t.belongs_to :domain
      t.belongs_to :document
    end
  end

  def down
    drop_table :documents_domains
  end
end
