class TableUserMessage < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.string :subject
      t.text :body
    end
  end
end
