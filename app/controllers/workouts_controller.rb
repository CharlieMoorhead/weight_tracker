class WorkoutsController < ApplicationController
  def new
  	  @title = "New Workout"
  	  @workout = Workout.new
  	  3.times do
  	  	  exercise = @workout.exercises.build
  	  	  3.times do
  	  	  	  set = exercise.exercise_sets.build
  	  	  	  3.times { set.repetitions.build }
		  end
	  end
  end

  def show
  	  @title = "Workout"
  	  @workout = Workout.find(params[:id])
  end

  def create
  	  @workout = Workout.new(params[:workout])
  	  @exercise = @workout.exercises.new(params[:workout][:exercises_attributes]["0"])
  	  if @workout.save
  	  	  if @exercise.save
			redirect_to workout_url(@workout)
		  else
		  	  render :new
		  end
	  else
	  	  render :new
	  end
  end

end
