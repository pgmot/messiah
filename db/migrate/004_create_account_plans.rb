class CreateAccountPlans < ActiveRecord::Migration
  def self.up
    create_table :account_plans do |t|
      t.integer :account_id
      t.integer :plan_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :account_plans
  end
end
