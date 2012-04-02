class DropRepetitions < ActiveRecord::Migration
  def self.up
    drop_table :repetitions
  end

  def self.down
    create_table :repetitions do |t|
      t.integer :weight
      t.integer :amount

      t.timestamps
	end
    add_column :repetitions, :set_id, :integer
  end
end
