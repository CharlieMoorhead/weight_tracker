class Exercise < ActiveRecord::Base
	before_validation :downcase_name
	attr_accessible :name

	has_many :exercise_sets, :dependent => :destroy

	validates :name, :presence => true, :length => { :maximum => 50 }

	private

		def downcase_name
			self.name = name.downcase
		end
end
