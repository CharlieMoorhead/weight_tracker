class AddNameUniquenessIndexToExercises < ActiveRecord::Migration
  def self.up
  	  add_index :exercises, :name, :unique => true
  end

  def self.down
  	  remove_index :exercises, :name
  end
end
