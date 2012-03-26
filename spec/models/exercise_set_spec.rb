require 'spec_helper'

describe ExerciseSet do

	before(:each) do
		@exercise = Factory(:exercise)
	end

	it "should create an instance" do
		@exercise.exercise_sets.create!()
	end

	it "should have the right exercise associated" do
		set = @exercise.exercise_sets.new()
		set.exercise_id.should == @exercise.id
		set.exercise.should == @exercise
	end
end
