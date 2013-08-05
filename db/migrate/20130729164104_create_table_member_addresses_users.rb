class CreateTableMemberAddressesUsers < ActiveRecord::Migration
  def up
    create_table :member_addresses_users do |t|
      t.belongs_to :address
      t.belongs_to :user
    end
  end

  def down
    drop_table :member_addresses_users
  end
end
