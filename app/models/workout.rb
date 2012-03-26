class Workout < ActiveRecord::Base

	has_many :exercises, :foreign_key => 'workout_id', :dependent => :destroy

	validates :date, :presence => true
	validates :bodyweight, :presence => true, :numericality => { :greater_than => 0 }

end
