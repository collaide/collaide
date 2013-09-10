class AddStudyLevelIdToAdvertisementAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisement_advertisements, :study_level_id, :integer
  end
end
