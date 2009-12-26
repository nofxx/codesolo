class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|

      t.string :login,            :limit =>  80,   :null => false
      t.string :email,            :limit => 100
      t.string :name,             :limit => 100,   :default => ''
      t.string :state,            :null  => false, :default => 'passive'
      t.string :motto, :url

      t.string :crypted_password, :password_salt, :null => true, :default => nil
      t.string :persistence_token, :single_access_token, :perishable_token,
               :current_login_ip, :last_login_ip

      t.string :time_zone, :locale, :limit => 50, :null => false
      t.datetime :last_login_at, :last_request_at, :current_login_at
      t.integer  :login_count, :skill
      # t.string :doc, :reg, :limit => 20
      # t.string :twitter_pass,     :limit => 50

      t.string    :avatar_file_name, :avatar_content_type
      t.integer   :avatar_file_size
      t.datetime  :avatar_updated_at

      t.boolean :admin, :null => false, :default => false

      t.string :openid_identifier

      t.timestamps
    end

    add_index :users, :name
    add_index :users, :admin
    add_index :users, :login, :unique => true
    add_index :users, :email
    add_index :users, :skill
    add_index :users, :persistence_token
    add_index :users, :perishable_token
    add_index :users, :single_access_token
    add_index :users, :last_request_at
    add_index :users, :openid_identifier
  end

  def self.down
    drop_table :users
  end
end
