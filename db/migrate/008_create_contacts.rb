class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.references :contactable, :limit => 20, :polymorphic => true

      t.string :kind,  :limit => 5, :null => false
      t.string :value, :limit => 50, :null => false
      t.text :info
    end

    add_index :contacts, :kind
    add_index :contacts, [:contactable_type, :contactable_id]
  end

  def self.down
    drop_table :contacts
  end
end
