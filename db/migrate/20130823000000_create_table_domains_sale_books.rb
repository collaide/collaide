class CreateTableDomainsSaleBooks < ActiveRecord::Migration
  def change
    create_table :domains_sale_books do |t|
      t.belongs_to :domain
      t.belongs_to :sale_book
    end
  end
end