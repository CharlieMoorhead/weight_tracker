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


  def graph
    unless Workout.exercise_exists?(params[:stat]) || (params[:stat] == "bodyweight" && Workout.has_bodyweight?)
      redirect_to workouts_url
    else
      @graph_title = params[:stat]
      @stats = params[:stat] == "bodyweight" ? make_bodyweight_stats : make_lift_stats(params[:stat])
    end
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

    def make_bodyweight_stats
      stats = []
      workouts = Workout.all.sort {|a,b| a.date <=> b.date}
      workouts.each do |workout|
        stats.push(format_for_highcharts(workout.date,workout.bodyweight.to_f)) if workout.bodyweight
      end
      return stats
    end
    
    def make_lift_stats(lift)
      stats = []
      workouts = Workout.all.sort {|a,b| a.date <=> b.date}
      workouts.each do |workout|
        if workout.find_exercise_by_name(lift)
          stats.push(format_for_highcharts(workout.date, 
                                           workout.find_exercise_by_name(lift).average_work_weight))
        end
      end
      return stats
    end

    def format_for_highcharts(date,stat)
      ["Date.UTC(#{date.year},#{date.month-1},#{date.day})",stat]
    end
end
