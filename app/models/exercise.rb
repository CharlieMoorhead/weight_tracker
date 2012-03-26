class Exercise < ActiveRecord::Base

	belongs_to :workout

	has_many :exercise_sets, :foreign_key => 'exercise_id', :dependent => :destroy

	validates :name, :presence => true, :length => { :maximum => 50 }

end
