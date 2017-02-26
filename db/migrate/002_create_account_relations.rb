class CreateAccountRelations < ActiveRecord::Migration
  def self.up
    create_table :account_relations do |t|
      t.string :uid
      t.string :follow_uid
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :account_relations
  end
end
