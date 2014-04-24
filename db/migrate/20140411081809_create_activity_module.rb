class CreateActivityModule < ActiveRecord::Migration
  def change
    create_table :activity_parameters do |t|
      t.belongs_to :owner, :polymorphic => true, index: true
      t.datetime :starting_at
      t.datetime :ending_at
      t.integer :condition, index: true

      t.timestamps
    end
    create_table :activity_activities do |t|
      t.belongs_to :trackable, :polymorphic => true, index: true
      t.belongs_to :owner, :polymorphic => true, index: true
      t.string  :key
      t.string :type
      t.text    :parameters
      t.belongs_to :recipient, :polymorphic => true, index: true

      t.timestamps
    end
  end
end