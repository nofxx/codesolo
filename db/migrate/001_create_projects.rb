class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name, :null => false
      t.string :url, :todo, :wiki, :forum, :mailist, :irc

      t.integer :devs, :karma, :skill, :todos, :forks, :watchers,
                :null => false, :default => 0

      t.text :info
      t.boolean :fork, :tests, :null => false, :default => false

      t.timestamp :synced_at
      t.timestamps
    end

    create_table :binds do |t|
      t.references :user, :project, :null => false
      t.string :kind, :null => false, :default => 'watch'
    end

    add_index :projects, :name
    add_index :projects, :devs
    add_index :projects, :karma
    add_index :projects, :skill
    add_index :projects, :url
    add_index :projects, :watchers
    add_index :projects, :forks
    add_index :projects, :synced_at

    add_index :binds, [:user_id, :project_id]
    add_index :binds, :user_id
    add_index :binds, :project_id
  end



  def self.down
    drop_table :projects
  end
end
