class UsersController < ApplicationController

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to workouts_url
    else
      render :new
    end
  end

end
