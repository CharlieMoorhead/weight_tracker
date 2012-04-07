require 'spec_helper'

describe WorkoutsController do
	render_views

	describe "GET 'new'" do
		it "should be successful" do
			get :new
			response.should be_success
		end

		it "should have a bodyweight input" do
			get :new
			response.should have_selector("input", :name => "workout[bodyweight]")
		end

		it "should have a note textarea" do
			get :new
			response.should have_selector("textarea", :name => "workout[note]")
		end

		it "should have date selectors" do
			get :new
			response.should have_selector("select", :name => "workout[date(1i)]")
			response.should have_selector("select", :name => "workout[date(2i)]")
			response.should have_selector("select", :name => "workout[date(3i)]")
		end

		it "should have an add exercise link" do
			get :new
			response.should have_selector("a", :content => "Add Exercise")
		end
	end

	describe "POST 'create'" do

		describe "failure" do

			before(:each) do
				@attr = { :bodyweight => nil, :date => nil }
			end

			it "should not create a workout" do
				lambda do
					post :create, :workout => @attr
				end.should_not change(Workout, :count)
			end

			it "should render the 'new' page" do
				post :create, :workout => @attr
				response.should render_template('new')
			end
		end

		describe "success" do

			before(:each) do
				@attr = { :bodyweight => 120, :date => Date.today }
			end

			it "should create a new workout" do
				lambda do
					post :create, :workout => @attr
				end.should change(Workout,:count).by(1)
			end

			it "should redirect to the index" do
				post :create, :workout => @attr
				response.should redirect_to(workouts_url)
			end
		end
	end

	describe "GET 'edit'" do

		before(:each) do
			@workout = Factory(:workout)
		end

		it "should be a success" do
			get :edit, :id => @workout
			response.should be_success
		end
	end

	describe "PUT 'update'" do

		before(:each) do
			@workout = Factory(:workout)
		end

		describe "failure" do

			before(:each) do
				@attr = { :bodyweight => nil, :date => nil }
			end

			it "should render the edit page" do
				put :update, :id => @workout, :workout => @attr
				response.should render_template(:edit)
			end
		end

		describe "success" do

			before(:each) do
				@attr = { :bodyweight => 150, :date => Date.tomorrow }
			end

			it "should update the workout attributes" do
				put :update, :id => @workout, :workout => @attr
				@workout.reload
				@workout.bodyweight.should == @attr[:bodyweight]
				@workout.date.should == @attr[:date]
			end

			it "should redirect to the index" do
				put :update, :id => @workout, :workout => @attr
				response.should redirect_to(workouts_url)
			end
		end
	end

	describe "DELETE 'destroy'" do
		
		before(:each) do
			@workout = Factory(:workout)
		end

		it "should delete the workout" do
			lambda do
				delete :destroy, :id => @workout
			end.should change(Workout,:count).by(-1)
		end

		it "should redirect to the index" do
			delete :destroy, :id => @workout
			response.should redirect_to(workouts_url)
		end
	end

	describe "GET 'index'" do

		before(:each)do
			@workouts = [Factory(:workout)]
			50.times do
				@workouts << Factory(:workout, :bodyweight => Factory.next(:bodyweight), :date => Factory.next(:date))
			end
		end

		it "should be a success" do
			get :index
			response.should be_success
		end

		it "should have an element for each workout" do
			get :index
			@workouts.each do |workout|
				response.should have_selector("td", :content => workout.date.to_s)
			end
		end
	end

	describe "GET 'graph'" do

    it "should redirect when a stat isn't provided" do
	    get :graph, :workouts => "workouts"
	    response.should redirect_to(workouts_url)
    end

    it "should redirect when a stat doesn't exist" do
      get :graph, :workouts => "workouts", :stat => "Empty"
      response.should redirect_to(workouts_url)
    end

    it "should be a success when a good stat happens" do
      workout = Factory(:workout)
      exercise = workout.exercises.create!(:name => "Squat")
      exercise.exercise_sets.create!(:weight => 5, :reps => 5)

      get :graph, :workouts => "workouts", :stat => "Squat"
      response.should be_success
    end
  end
end
