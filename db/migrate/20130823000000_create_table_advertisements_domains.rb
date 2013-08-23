class CreateTableAdvertisementsDomains < ActiveRecord::Migration
  def change
    # C'est dans advertisements, car il y a l'héritage
    create_table :advertisements_domains do |t|
      t.belongs_to :domain
      t.belongs_to :sale_book
    end
  end
end