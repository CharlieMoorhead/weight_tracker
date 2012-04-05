class AddFailureToExerciseSet < ActiveRecord::Migration
  def self.up
    add_column :exercise_sets, :failure, :boolean, :default => false
  end

  def self.down
    remove_column :exercise_sets, :failure
  end
end
