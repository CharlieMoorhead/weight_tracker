require 'spec_helper'

describe WorkoutsController do
	render_views

  describe "not signed-in" do

    it "should redirect from GET 'new'" do
      get :new, :user_id => 1
      response.should be_redirect
    end

    it "should redirect from POST 'create'" do
      lambda do
        attr = { :bodyweight => 150, :date => Date.today }
        post :create, :user_id => 1, :workout => attr
        response.should be_redirect
      end.should_not change(Workout, :count)
    end

    it "should redirect from DELETE 'destroy'" do
      lambda do
        delete :destroy, :id => 1, :user_id => 1
        response.should be_redirect
      end.should_not change(Workout, :count)
    end

    it "should redirect from GET 'graph'" do
      get :graph, :user_id => 1, :stat => "bodyweight"
      response.should be_redirect
    end

    it "should redirect from GET 'index'" do
      get :index, :user_id => 1
      response.should be_redirect
    end

    it "should redirect from GET 'edit'" do
      get :edit, :user_id => 1, :id => 1
      response.should be_redirect
    end

    it "should redirect from PUT 'update'" do
      attr = { :bodyweight => 150, :date => Date.today }
      put :update, :user_id => 1, :id => 1, :workout => attr
      response.should be_redirect
    end
  end

	describe "for signed-in users" do

	  before(:each) do
	    @user = Factory(:user)
	    test_sign_in(@user)
    end

    describe "GET 'new'" do
      it "should be successful" do
        get :new, :user_id => @user.id
        response.should be_success
      end

      it "should have a bodyweight input" do
        get :new, :user_id => @user.id
        response.should have_selector("input", :name => "workout[bodyweight]")
      end

      it "should have a note textarea" do
        get :new, :user_id => @user.id
        response.should have_selector("textarea", :name => "workout[note]")
      end

      it "should have a date input" do
        get :new, :user_id => @user.id
        response.should have_selector("input", :name => "workout[date]")
      end

      it "should have an add exercise link" do
        get :new, :user_id => @user.id
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
            post :create, :workout => @attr, :user_id => @user.id
          end.should_not change(Workout, :count)
        end

        it "should render the 'new' page" do
          post :create, :workout => @attr, :user_id => @user.id
          response.should render_template('new')
        end
      end

      describe "success" do

        before(:each) do
          @attr = { :bodyweight => 120, :date => Date.today }
        end

        it "should create a new workout" do
          lambda do
            post :create, :workout => @attr, :user_id => @user.id
          end.should change(Workout,:count).by(1)
        end

        it "should redirect to the index" do
          post :create, :workout => @attr, :user_id => @user.id
          response.should redirect_to(user_workouts_url)
        end
      end
    end

    describe "GET 'edit'" do

      before(:each) do
        @workout = Factory(:workout)
      end

      it "should be a success" do
        get :edit, :id => @workout, :user_id => @user.id
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
          put :update, :id => @workout, :workout => @attr, :user_id => @user.id
          response.should render_template(:edit)
        end
      end

      describe "success" do

        before(:each) do
          @attr = { :bodyweight => 150, :date => Date.tomorrow }
        end

        it "should update the workout attributes" do
          put :update, :id => @workout, :workout => @attr, :user_id => @user.id
          @workout.reload
          @workout.bodyweight.should == @attr[:bodyweight]
          @workout.date.should == @attr[:date]
        end

        it "should redirect to the index" do
          put :update, :id => @workout, :workout => @attr, :user_id => @user.id
          response.should redirect_to(user_workouts_url)
        end
      end
    end

    describe "DELETE 'destroy'" do
		
      before(:each) do
        @workout = Factory(:workout)
      end

      it "should delete the workout" do
        lambda do
          delete :destroy, :id => @workout, :user_id => @user
        end.should change(Workout,:count).by(-1)
      end

      it "should redirect to the index" do
        delete :destroy, :id => @workout, :user_id => @user
        response.should redirect_to(user_workouts_url)
      end
    end

    describe "GET 'index'" do

      before(:each)do
        50.times do
          Factory(:workout, :bodyweight => Factory.next(:bodyweight), :date => Factory.next(:date), :user_id => @user.id)
        end
      end

      it "should be a success" do
        get :index, :user_id => @user.id
        response.should be_success
      end

      it "should have an element for each workout" do
        get :index, :user_id => @user.id
        @user.workouts.each do |workout|
          response.should have_selector("td", :content => workout.date.to_s)
        end
      end
    end

    describe "GET 'graph'" do

      it "should redirect when a stat isn't provided" do
        get :graph, :user_id => @user.id
        response.should redirect_to(user_workouts_url)
      end

      it "should redirect when a stat doesn't exist" do
        get :graph, :stat => "Empty", :user_id => @user.id
        response.should redirect_to(user_workouts_url)
      end

      it "should be a success when a good stat happens" do
        workout = Factory(:workout, :user_id => @user.id)
        exercise = workout.exercises.create!(:name => "Squat")
        exercise.exercise_sets.create!(:weight => 5, :reps => 5)

        get :graph, :stat => "Squat", :user_id => @user.id
        response.should be_success
      end
    end
  end
end
