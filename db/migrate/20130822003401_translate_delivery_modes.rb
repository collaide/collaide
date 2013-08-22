# -*- encoding : utf-8 -*-
class TranslateAdvertisementDeliveryModes < ActiveRecord::Migration
  def self.up
    Advertisement::DeliveryMode.create_translation_table!({
      :name => :string,
      :description => :text}, {
        :migrate_data => true
      })
  end

  def self.down
    Advertisement::DeliveryMode.drop_translation_table! :migrate_data => true
  end
end
