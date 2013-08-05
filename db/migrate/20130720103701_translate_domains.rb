class TranslateDomains < ActiveRecord::Migration
  def self.up
    Domain.create_translation_table!({
      :name => :string,
      :description => :text}, {
        :migrate_data => true
      })
  end

  def self.down
    Domain.drop_translation_table! :migrate_data => true
  end
end
