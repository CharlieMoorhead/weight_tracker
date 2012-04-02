class WorkoutsController < ApplicationController
  def new
  	  @title = "New Workout"
  	  @workout = Workout.new
  end

  def show
  	  @title = "Workout"
  	  @workout = Workout.find(params[:id])
  end

  def create
  	  @workout = Workout.new(params[:workout])
  	  if @workout.save
			redirect_to workout_url(@workout)
	  else
	  	  render :new
	  end
  end

end
