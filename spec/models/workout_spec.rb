require 'spec_helper'

describe Workout do

	before(:each) do
		@attr = { :date => Date.today, :bodyweight => 150.5, :note => "First workout" }
	end

	it "should create an instance given valid attributes" do
		Workout.create!(@attr)
	end

	describe "validations" do

		it "should require a date" do
			workout = Workout.new(@attr.merge(:date => nil))
			workout.should_not be_valid
		end

		it "should reject a non-positive bodyweight" do
			workout = Workout.new(@attr.merge(:bodyweight => 0))
			workout.should_not be_valid
		end
	end
end
