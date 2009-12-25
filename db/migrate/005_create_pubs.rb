class CreatePubs < ActiveRecord::Migration
  def self.up
    create_table :pubs do |t|
      t.references :user, :project
      t.string :head, :null => false
      t.text :body

      t.timestamps
    end

    add_index :pubs, :user_id
    add_index :pubs, :project_id
    add_index :pubs, :head
  end

  def self.down
    drop_table :pubs
  end
end
