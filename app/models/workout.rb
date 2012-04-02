class Workout < ActiveRecord::Base
	attr_accessible :date, :bodyweight, :note, :exercises_attributes

	has_many :exercises, :dependent => :destroy
	accepts_nested_attributes_for :exercises

	validates :date, :presence => true
	validates :bodyweight, :presence => true, :numericality => { :greater_than => 0 }

end
