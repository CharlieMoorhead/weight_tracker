class Workout < ActiveRecord::Base
	attr_accessible :date, :bodyweight, :note, :exercise_sets_attributes

	has_many :exercise_sets, :dependent => :destroy
	accepts_nested_attributes_for :exercise_sets

	validates :date, :presence => true
	validates :bodyweight, :presence => true, :numericality => { :greater_than => 0 }

end
