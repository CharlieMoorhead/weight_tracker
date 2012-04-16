class AddUsernameUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :username, :unique => true
  end

  def self.down
    remove_index :users, :email
  end
end
