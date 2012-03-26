require 'spec_helper'

describe Repetition do

	before(:each) do
		@set = Factory(:exercise_set)
		@attr = { :weight => 100, :amount => 10 }
	end

	it "should create an instance given valid attributes" do
		@set.repetitions.create!(@attr)
	end

	describe "validations" do

		it "should have the right set_id" do
			rep = @set.repetitions.new(@attr)
			rep.set_id.should == @set.id
		end

		it "should require a weight" do
			rep = @set.repetitions.new(@attr.merge(:weight => nil))
			rep.should_not be_valid
		end

		it "should require a non-negative weight" do
			rep = @set.repetitions.new(@attr.merge(:weight => -1))
			rep.should_not be_valid
		end

		it "should require a number" do
			rep = @set.repetitions.new(@attr.merge(:amount => nil))
			rep.should_not be_valid
		end

		it "should require a non-negative weight" do
			rep = @set.repetitions.new(@attr.merge(:amount => -1))
			rep.should_not be_valid
		end
	end
end
