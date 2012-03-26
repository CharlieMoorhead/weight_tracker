class Repetition < ActiveRecord::Base

	belongs_to :exercise_set

	validates :weight, :presence => true,
						:numericality => { :greater_than_or_equal_to => 0 }
	validates :amount, :presence => true,
						:numericality => { :greater_than_or_equal_to => 0 }
	validates :set_id, :presence => true

end
