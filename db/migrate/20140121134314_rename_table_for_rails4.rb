class RenameTableForRails4 < ActiveRecord::Migration
  def change
    rename_table :delivery_modes_sales, :advertisement_delivery_modes
    rename_table :documents_domains, :document_documents_domains
    rename_table :payment_modes_sales, :advertisement_payment_modes
  end
end
