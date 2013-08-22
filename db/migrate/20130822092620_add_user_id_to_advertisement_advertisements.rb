class AddUserIdToAdvertisementAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisement_advertisements, :user_id, :int
  end
end
