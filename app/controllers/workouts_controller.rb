class WorkoutsController < ApplicationController
  def new
  	  @title = "New Workout"
  	  @workout = Workout.new
  end

  def edit
  	  @title = "Edit Workout"
  	  @workout = Workout.find(params[:id])
  end

  def create
  	  @workout = Workout.new(params[:workout])
  	  if @workout.save
			redirect_to workouts_url
	  else
	  	  render :new
	  end
  end

  def update
  	  @workout = Workout.find(params[:id])
  	  if @workout.update_attributes(params[:workout])
  	  	  redirect_to workouts_url
	  else
	  	  render :edit
	  end
  end

  def index
  	  @title = "Workouts"
  	  @workouts = Workout.all.sort {|a,b| a.date <=> b.date}
  	  @exercises = find_all_exercises(@workouts)
  end

  def destroy
  	  Workout.find(params[:id]).destroy
  	  redirect_to workouts_url
  end

  private

	def find_all_exercises(workouts)
		exercises = []
		workouts.each do |workout|
			workout.exercises.each do |exercise|
				unless exercises.include?(exercise.name)
					exercises.push(exercise.name)
				end
			end
		end
		return exercises
	end

end
