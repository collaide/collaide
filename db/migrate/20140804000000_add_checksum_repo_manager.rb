class AddChecksumRepoManager < ActiveRecord::Migration
  def change
    add_column :rm_repo_items, :checksum, :string
  end
end