class Exercise < ActiveRecord::Base
	before_validation :format_name
	attr_accessible :name, :exercise_sets_attributes

	belongs_to :workout
	has_many :exercise_sets, :dependent => :destroy
	accepts_nested_attributes_for :exercise_sets, :allow_destroy => true

	validates :name, :presence => true, :length => { :maximum => 50 }

  def average_work_weight
    (sum_weights.to_f / exercise_sets.count).round(2)
  end

	private

		def format_name
			self.name = name.downcase.capitalize
		end

		def sum_weights
		  sum = 0
		  exercise_sets.each do |set|
		    sum += set.weight
      end
      return sum
    end
end
