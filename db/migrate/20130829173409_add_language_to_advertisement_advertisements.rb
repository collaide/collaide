# -*- encoding : utf-8 -*-
class AddLanguageToAdvertisementAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisement_advertisements, :language, :string
  end
end
