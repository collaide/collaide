# -*- encoding : utf-8 -*-
class CreateTableUser < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      t.string :name
      t.string :role
      t.string :avatar

      ## Add by us
      t.integer :points, default: 5
      t.boolean :has_notifications, default:  false
      t.string :provider
      t.string :uid
      t.string :old_password
      t.boolean :old_user, defaults: false
      t.integer :old_id

      t.float :latitude
      t.float :longitude

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      # Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Token authenticatable
      t.string :authentication_token


      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :unlock_token,         :unique => true
    add_index :users, :authentication_token, :unique => true

    create_table :guest_books do |t|
      t.string :name
      t.text :comment

      t.timestamps
    end

    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.string :token
      t.string :secret
      t.string :username

      t.timestamps
    end

    create_table :domains do |t|
      t.string :name
      t.text :description
      t.string :ancestry, index: true
      t.integer :position

      t.timestamps
    end

    Domain.create_translation_table! name: :string, description: :text

    create_table :member_studies do |t|
      t.date :started_at
      t.date :ended_at
      t.string :orientation
      t.belongs_to :users, index: true

      t.timestamps
    end

    create_table :topics do |t|
      t.string :title
      t.text :message
      t.belongs_to :owner, polymorphic: true, index: true
      t.belongs_to :writer, polymorphic: true, index: true

      t.timestamps
    end

    create_table :contacts do |t|
      t.string :subject
      t.string :email
      t.string :content

      t.timestamps
    end

    create_table :addresses do |t|
      t.string :country
      t.string :street
      t.integer :street_number
      t.integer :city_code
      t.string :country_code
      t.boolean :is_actual, default: true

      t.timestamps
    end

    create_table :member_contacts do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :gender
      t.belongs_to :users, index: true

      t.timestamps
    end

    create_table :member_friend_friends do |t|
      t.belongs_to :users, index: true

      t.timestamps
    end

    create_table :member_friend_demands do |t|
      t.text :message
      t.integer :user_has_sent_id
      t.integer :user_is_invited_id

      t.timestamps
    end

    create_join_table :user_users, :user_friend_demands

    create_table :member_users_addresses do |t|
      t.belongs_to :owner, polymorphic: true, index: true
      t.belongs_to :addresses

      t.timestamps
    end

    create_table :app_notifications do |t|
      t.string :class_name
      t.string :method_name
      t.string :values
      t.boolean :is_viewed, default: false
      t.belongs_to :owner, polymorphic: true, index: true

      t.timestamps
    end

  end




end
