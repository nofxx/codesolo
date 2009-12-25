class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name, :null => false
      t.string :url, :todo, :wiki, :forum, :mailist, :irc

      t.integer :karma, :skill, :null => false, :default => 0

      t.timestamps
    end

    create_table :binds do |t|
      t.references :user, :project, :null => false
      t.string :kind, :null => false, :default => 'watch'
    end

    add_index :projects, :name
    add_index :projects, :karma
    add_index :projects, :skill
    add_index :projects, :url

    add_index :binds, [:user_id, :project_id]
    add_index :binds, :user_id
    add_index :binds, :project_id
  end



  def self.down
    drop_table :projects
  end
end
