class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.references :project, :user
      t.string :name, :null => false
      t.integer :priority, :null => false, :default => 0
      t.boolean :done, :null => false, :default => false

      t.timestamps
    end

    add_index :todos, :project_id
    add_index :todos, :user_id
    add_index :todos, :priority
    add_index :todos, :done
    add_index :todos, :name
  end

  def self.down
    drop_table :todos
  end
end
