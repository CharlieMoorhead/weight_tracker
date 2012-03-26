class AddWorkoutIdToExercise < ActiveRecord::Migration
  def self.up
    add_column :exercises, :workout_id, :integer
  end

  def self.down
    remove_column :exercises, :workout_id
  end
end
