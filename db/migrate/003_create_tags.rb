class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name, :null => false
      t.integer :taggings_count, :null => false, :default => 0
    end

    create_table :taggings do |t|
      t.references :tag, :null => false
      t.references :taggable, :polymorphic => true
    end

    add_index :tags,     :name
    add_index :tags,     :taggings_count
    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type]
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
