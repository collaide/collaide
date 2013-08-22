# -*- encoding : utf-8 -*-
class TranslateAdvertisementPaymentModes < ActiveRecord::Migration
  def self.up
    Advertisement::PaymentMode.create_translation_table!({
      :name => :string,
      :description => :text}, {
        :migrate_data => true
      })
  end

  def self.down
    Advertisement::PaymentMode.drop_translation_table! :migrate_data => true
  end
end
