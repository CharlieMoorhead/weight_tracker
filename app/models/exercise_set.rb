class ExerciseSet < ActiveRecord::Base
	attr_accessible :reps, :weight, :failure

	belongs_to :exercise

	validates :reps, :presence => true,
						:numericality => { :greater_than => 0 }
	validates :weight, :presence => true,
						:numericality => { :greater_than => 0 }

end
