class ExerciseSet < ActiveRecord::Base
	attr_accessible :reps, :weight, :exercise_attributes

	belongs_to :exercise
	accepts_nested_attributes_for :exercise, :reject_if => :check_exercise
	belongs_to :workout

	validates :reps, :presence => true,
						:numericality => { :greater_than => 0 }
	validates :weight, :presence => true,
						:numericality => { :greater_than => 0 }

	private
		
		def check_exercise(exercise_attr)
			if exercise = Exercise.find_by_name(exercise_attr[:name].downcase)
				self.exercise = exercise
			end
		end


end
