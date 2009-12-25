class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name, :null => false
      t.text   :info
      t.timestamp :sync_at
      t.string :permalink

      t.string    :avatar_file_name, :avatar_content_type
      t.integer   :avatar_file_size
      t.datetime  :avatar_updated_at

      t.timestamps
    end

    add_index :groups, :name
    add_index :groups, :sync_at
  end

  def self.down
    drop_table :groups
  end
end
