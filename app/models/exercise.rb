class Exercise < ActiveRecord::Base
	before_validation :format_name
	attr_accessible :name, :exercise_sets_attributes

	belongs_to :workout
	has_many :exercise_sets, :dependent => :destroy
	accepts_nested_attributes_for :exercise_sets, :allow_destroy => true

	validates :name, :presence => true, :length => { :maximum => 50 }

  def average_work_weight
    unless successful_sets == 0
      return (sum_weights.to_f / successful_sets).round(2)
    else
      return nil
    end
  end

	private

		def format_name
			self.name = name.downcase.capitalize
		end

		def successful_sets
		  count = 0
		  exercise_sets.each do |set|
		    count += 1 unless set.failure
      end
      return count
    end

		def sum_weights
		  sum = 0
		  exercise_sets.each do |set|
		    sum += set.weight unless set.failure
      end
      return sum
    end
end
