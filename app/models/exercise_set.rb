class ExerciseSet < ActiveRecord::Base

	belongs_to :exercise

	has_many :repetitions, :foreign_key => 'set_id', :dependent => :destroy

end
