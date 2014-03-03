class CreateEmailInvitation < ActiveRecord::Migration
  def change
    create_table :group_email_invitations do |t|
      t.string :email
      t.text :message
      t.string :secret_token
      t.belongs_to :group_group
      t.belongs_to :user
    end
  end
end
