require 'spec_helper'

describe ExerciseSet do

	before(:each) do
		@exercise = Factory(:exercise)
		@attr = { :reps => 5, :weight => 150 }
	end

	it "should create an instance given valid attributes" do
		@exercise.exercise_sets.create!(@attr)
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

		it "should have a default 'false' value for failure" do
			set = @exercise.exercise_sets.new(@attr)
			set.failure.should == false
		end

		it "should have the right exercise associated" do
			set = @exercise.exercise_sets.new(@attr)
			set.exercise_id.should == @exercise.id
			set.exercise.should == @exercise
		end
	end
end
