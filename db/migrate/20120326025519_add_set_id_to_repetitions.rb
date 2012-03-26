class AddSetIdToRepetitions < ActiveRecord::Migration
  def self.up
    add_column :repetitions, :set_id, :integer
  end

  def self.down
    remove_column :repetitions, :set_id
  end
end
