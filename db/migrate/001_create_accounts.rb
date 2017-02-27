class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.string :screen_name
      t.string :icon_url
      t.string :access_token
      t.string :access_token_secret

      t.string :role

      t.string :uid
      t.string :provider

      t.float :living_latitude
      t.float :living_longitude
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :accounts
  end
end
