require 'spec_helper'

describe SessionsController do
  render_views

  before(:each) do
    @user = Factory(:user)
  end

  describe "for already signed-in users" do

    before(:each) do
      test_sign_in(@user)
    end

    it "should redirect from GET 'new'" do
      get :new
      response.should be_redirect
    end

    it "should redirect from POST 'create'" do
      attr = { :username => @user.username, :password => @user.password }
      post :create, :session => attr
      response.should be_redirect
    end
  end

  describe "GET 'new'" do

    it "should be a success" do
      get :new
      response.should be_success
    end

    it "should have a username input" do
      get :new
      response.should have_selector("input", :name => "session[username]")
    end

    it "should have a password input" do
      get :new
      response.should have_selector("input", :name => "session[password]")
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :username => "", :password => "" }
      end

      it "should render the 'new' page" do
        post :create, :session => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = {:username => @user.username, :password => @user.password }
      end

      it "should redirect to the user's workout index" do
        post :create, :session => @attr
        response.should be_redirect
      end
    end
  end
end
