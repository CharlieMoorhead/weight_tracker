require 'spec_helper'

describe WorkoutsController do
	render_views

	describe "GET 'show'" do
		
		before(:each) do
			@workout = Factory(:workout)
		end

		it "should be successful" do
			get :show, :id => @workout
			response.should be_success
		end
	end

	describe "GET 'new'" do
		it "should be successful" do
			get 'new'
			response.should be_success
		end
	end
end
