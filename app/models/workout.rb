class Workout < ActiveRecord::Base
	attr_accessible :date, :bodyweight, :note, :exercises_attributes

	belongs_to :user
	has_many :exercises, :dependent => :destroy
	accepts_nested_attributes_for :exercises, :allow_destroy => true

	validates :date, :presence => true
	validates :bodyweight, :numericality => { :greater_than => 0, :allow_blank => true }

	def find_exercise_by_name(name)
		exercises.each do |exercise|
			if exercise.name == name
				return exercise
			end
		end
		return nil
	end

end
