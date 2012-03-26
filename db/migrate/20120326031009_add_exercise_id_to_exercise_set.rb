class AddExerciseIdToExerciseSet < ActiveRecord::Migration
  def self.up
    add_column :exercise_sets, :exercise_id, :integer
  end

  def self.down
    remove_column :exercise_sets, :exercise_id
  end
end
