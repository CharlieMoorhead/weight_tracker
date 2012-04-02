class AddWorkoutIdToExerciseSet < ActiveRecord::Migration
  def self.up
    add_column :exercise_sets, :workout_id, :integer
    add_column :exercise_sets, :reps, :decimal
    add_column :exercise_sets, :weight, :decimal
  end

  def self.down
    remove_column :exercise_sets, :weight
    remove_column :exercise_sets, :reps
    remove_column :exercise_sets, :workout_id
  end
end
