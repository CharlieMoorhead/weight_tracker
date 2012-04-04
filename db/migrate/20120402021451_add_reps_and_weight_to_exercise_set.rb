class AddRepsAndWeightToExerciseSet < ActiveRecord::Migration
  def self.up
    add_column :exercise_sets, :reps, :integer
    add_column :exercise_sets, :weight, :integer
  end

  def self.down
    remove_column :exercise_sets, :weight
    remove_column :exercise_sets, :reps
  end
end
