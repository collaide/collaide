# -*- encoding : utf-8 -*-
class TranslateAdvertisementDeliveryModes < ActiveRecord::Migration
  def up
    Advertisement::DeliveryMode.create_translation_table!({
                                                       name: :string,
                                                       description: :text
                                                   })
  end

  def down
    Advertisement::DeliveryMode.drop_translation_table!
  end
end