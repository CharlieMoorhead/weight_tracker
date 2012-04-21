require 'spec_helper'

describe Workout do

	before(:each) do
		@user = Factory(:user)
		@attr = { :date => Date.today, :bodyweight => 150.5, :note => "First workout" }
	end

	it "should create an instance given valid attributes" do
		@user.workouts.create!(@attr)
	end

  describe "relationships" do

    before(:each) do
      @workout = @user.workouts.new(@attr)
    end

    it "should have a user attribute" do
      @workout.should respond_to(:user)
    end

    it "should have the right user associated" do
      @workout.user.id.should == @user.id
      @workout.user.should == @user
    end

    it "should have an exercises attribute" do
      @workout.should respond_to(:exercises)
    end
  end

	describe "validations" do

		it "should require a date" do
			workout = @user.workouts.new(@attr.merge(:date => nil))
			workout.should_not be_valid
		end

		it "should reject a non-positive bodyweight" do
			workout = @user.workouts.new(@attr.merge(:bodyweight => 0))
			workout.should_not be_valid
		end
	end
end
