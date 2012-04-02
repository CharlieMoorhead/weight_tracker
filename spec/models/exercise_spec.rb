require 'spec_helper'

describe Exercise do

	before(:each) do
		@attr = { :name => "squat" }
	end

	it "should create a new instance given valid attributes" do
		Exercise.create!(@attr)
	end

	describe "validations" do
		
		it "should require a name" do
			exercise = Exercise.new(@attr.merge(:name => ""))
			exercise.should_not be_valid
		end

		it "should reject long names" do
			exercise = Exercise.new(@attr.merge(:name => "a" * 51))
			exercise.should_not be_valid
		end
	end
end
