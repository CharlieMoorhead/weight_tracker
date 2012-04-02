class AddNameIndexToExercises < ActiveRecord::Migration
  def self.up
  	  add_index :exercises, :name
  end

  def self.down
  	  remove_index :exercises, :name
  end
end
