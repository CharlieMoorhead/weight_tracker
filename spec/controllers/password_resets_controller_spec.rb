require 'spec_helper'

describe PasswordResetsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new 
      response.should be_success
    end

    it "should have an email input" do
      get 'new'
      response.should have_selector("input", :name => "email")
    end
  end
end
