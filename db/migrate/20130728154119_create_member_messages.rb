class CreateMemberMessages < ActiveRecord::Migration
  def change
    create_table :member_messages do |t|
      t.boolean :is_send, default: false
      t.datetime :send_at
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
