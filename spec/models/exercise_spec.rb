require 'spec_helper'

describe Exercise do

	before(:each) do
		@workout = Factory(:workout)
		@attr = { :name => "squat" }
	end

	it "should create a new instance given valid attributes" do
		@workout.exercises.create!(@attr)
	end

	describe "validations" do
		
		it "should have the right workout_id" do
			exercise = @workout.exercises.new(@attr)
			exercise.workout.id.should == @workout.id
			exercise.workout.should == @workout
		end

		it "should require a name" do
			exercise = @workout.exercises.new(@attr.merge(:name => ""))
			exercise.should_not be_valid
		end

		it "should reject long names" do
			exercise = @workout.exercises.new(@attr.merge(:name => "a" * 51))
			exercise.should_not be_valid
		end
	end
end
