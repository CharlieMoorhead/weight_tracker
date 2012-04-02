require 'spec_helper'

describe ExerciseSet do

	before(:each) do
		@workout = Factory(:workout)
		@exercise = Factory(:exercise)
		@attr = { :reps => 5, :weight => 150, :exercise_attributes => {:name => @exercise.name} }
	end

	it "should create an instance given valid attributes" do
		@workout.exercise_sets.create!(@attr)
	end

	describe "validations" do

		it "should require a reps attribute" do
			set = @exercise.exercise_sets.new(@attr.merge(:reps => nil))
			set.should_not be_valid
		end

		it "should reject non-positive reps" do
			set = @exercise.exercise_sets.new(@attr.merge(:reps => 0))
			set.should_not be_valid
		end

		it "should require a weight attribute" do
			set = @exercise.exercise_sets.new(@attr.merge(:weight => nil))
			set.should_not be_valid
		end

		it "should reject non-positive weight" do
			set = @exercise.exercise_sets.new(@attr.merge(:weight => 0))
			set.should_not be_valid
		end

		it "should have the right exercise associated" do
			set = @workout.exercise_sets.new(@attr)
			set.exercise_id.should == @exercise.id
			set.exercise.should == @exercise
		end

		it "should have the right workout associated" do
			set = @workout.exercise_sets.new
			set.workout_id.should == @workout.id
			set.workout.should == @workout
		end
	end
end
