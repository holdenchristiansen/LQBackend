class DeviseTokenAuthCreateUsers < ActiveRecord::Migration
  def change
    ## Required
    add_column :users, :provider, :string, :null => false, :default => "email"
    add_column :users, :uid, :string, :null => false, :default => ""

    add_column :users, :nickname, :string
    add_column :users, :image, :string
    add_column :users, :tokens, :json

    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string

    add_index :users, [:uid, :provider],     :unique => true
  end
end
