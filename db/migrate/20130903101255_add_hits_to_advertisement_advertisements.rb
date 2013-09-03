class AddHitsToAdvertisementAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisement_advertisements, :hits, :integer, :default => 0
  end
end
