class Exercise < ActiveRecord::Base
	before_validation :format_name
	attr_accessible :name, :exercise_sets_attributes

	belongs_to :workout
	has_many :exercise_sets, :dependent => :destroy
	accepts_nested_attributes_for :exercise_sets, :allow_destroy => true

	validates :name, :presence => true, :length => { :maximum => 50 }

	private

		def format_name
			self.name = name.downcase.capitalize
		end
end
