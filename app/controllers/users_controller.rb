class UsersController < ApplicationController
  before_filter :already_signed_in

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.hello.deliver
      sign_in @user
      redirect_to user_workouts_url(@user)
    else
      @user.password = ""
      @user.password_confirmation = ""
      render :new
    end
  end

end
