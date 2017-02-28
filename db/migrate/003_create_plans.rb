class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.integer :owner_user_id
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.text :meshiya
      t.float :latitude
      t.float :longitude
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :plans
  end
end
