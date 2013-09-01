# -*- encoding : utf-8 -*-
class CreateTranslateAdvertisementPaymentMode < ActiveRecord::Migration
  def up
    Advertisement::PaymentMode.create_translation_table!({
                                                       name: :string,
                                                       description: :text
                                                   })
  end

  def down
    Advertisement::PaymentMode.drop_translation_table!
  end
end
