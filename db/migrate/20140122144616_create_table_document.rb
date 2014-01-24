class CreateTableDocument < ActiveRecord::Migration
  def change
      create_table :document_types do |t|
        t.string :name
        t.text :description

        t.timestamps
      end

      create_table :document_documents do |t|
        t.string :title
        t.text :description
        t.string :author
        t.integer :number_of_pages
        t.date :realized_at
        t.string :language
        t.string :asset
        t.boolean :is_accepted, default: false

        t.belongs_to :document_type, index: true
        t.belongs_to :user

        t.string :status, default: 'pending'
        t.integer :hits, default: 0
        t.boolean :is_deleted, default: false

        # Enum
        t.string :study_level

        t.timestamps
      end

      create_table :document_documents_domains do |t|
        t.integer :document_id, index: true
        t.integer :domain_id, index: true
      end

      Document::Type.create_translation_table!({
                                                   name: :string,
                                                   description: :text
                                               })

      create_table :document_downloads do |t|
        t.belongs_to :user
        t.integer :documents_id
        t.integer :number_of_downloads
        t.timestamps
      end

      create_table :comments do |t|
        t.string :title, :limit => 50, :default => ""
        t.text :comment
        t.references :commentable, :polymorphic => true, index: true
        t.references :owner, polymorphic: true, index: true
        t.timestamps
      end

  end
end
