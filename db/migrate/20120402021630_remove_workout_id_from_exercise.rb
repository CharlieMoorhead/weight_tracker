class RemoveWorkoutIdFromExercise < ActiveRecord::Migration
  def self.up
    remove_column :exercises, :workout_id
  end

  def self.down
    add_column :exercises, :workout_id, :integer
  end
end
