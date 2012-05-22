require 'spec_helper'

describe UsersController do
  render_views

  describe "for already signed-in users" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should redirect from GET 'new'" do
      get :new
      response.should be_redirect
    end

    it "should redirect from POST 'create'" do
      lambda do
        attr = { :username => "example", :email => "hi@example.com", :password => "foobar" }
        post :create, :user => attr
        response.should be_redirect
      end.should_not change(User,:count)
    end
  end

  describe "GET 'new'" do

    it "should be a success" do
      get :new
      response.should be_success
    end

    it "should have a username input" do
      get :new
      response.should have_selector("input", :name => "user[username]")
    end

    it "should have a password input" do
      get :new
      response.should have_selector("input", :name => "user[password]")
    end

    it "should have a password confirmation input" do
      get :new
      response.should have_selector("input", :name => "user[password_confirmation]")
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :username => "", :email => "", :password => "" }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = {:username => "example", :email => "hi@example.com", :password => "foobar" }
      end

      it "should create a new user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user's workout index" do
        post :create, :user => @attr
        response.should be_redirect
      end
    end
  end
end
