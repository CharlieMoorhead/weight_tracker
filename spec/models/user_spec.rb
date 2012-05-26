require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :username => "username",
              :email => "email",
              :password => "password",
              :password_confirmation => "password" }
  end

  it "should create an instance given valid attributes" do
    User.create!(@attr)
  end

  it "should have a workouts attribute" do
    user = User.new(@attr)
    user.should respond_to(:workouts)
  end

  describe "validations" do

    it "should require a username" do
      user = User.new(@attr.merge(:username => ""))
      user.should_not be_valid
    end

    it "should reject a long username" do
      long = "a" * 51
      user = User.new(@attr.merge(:username => long))
      user.should_not be_valid
    end

    it "should require an email" do
      user = User.new(@attr.merge(:email => ""))
      user.should_not be_valid
    end

    it "should require a password" do
      user = User.new(@attr.merge(:password => "", :password_confirmation => ""))
      user.should_not be_valid
    end

    it "should reject a short password" do
      short = "a" * 3
      user = User.new(@attr.merge(:password => short, :password_confirmation => short))
      user.should_not be_valid
    end

    it "should reject a long password" do
      long = "a" * 41
      user = User.new(@attr.merge(:password => long, :password_confirmation => long))
      user.should_not be_valid
    end

    it "should require matching password confirmation" do
      user = User.new(@attr.merge(:password_confirmation => "invalid"))
      user.should_not be_valid
    end
  end

  describe "encrypted_password" do

    before(:each) do
      @user = User.create(@attr)
    end

    it "should have the encrypted_password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted_password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end
  end
end
