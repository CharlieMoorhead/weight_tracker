class WorkoutsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user

  def new
    @title = "New Workout"
    @user = User.find(params[:user_id])
    @workout = @user.workouts.new
  end

  def edit
    @title = "Edit Workout"
    @workout = Workout.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @workout = @user.workouts.new(params[:workout])
    if @workout.save
      redirect_to user_workouts_url
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:user_id])
    @workout = Workout.find(params[:id])
    if @workout.update_attributes(params[:workout])
      redirect_to user_workouts_url
    else
      render :edit
    end
  end

  def index
    @title = "Workouts"
    @user = User.find(params[:user_id])
    @workouts = @user.workouts.all.sort {|a,b| b.date <=> a.date}
    @exercises = find_all_exercises(@workouts)
  end

  def destroy
    Workout.find(params[:id]).destroy
    redirect_to user_workouts_url
  end


  def graph
    @user = User.find(params[:user_id])
    @workouts = @user.workouts.all.sort {|a,b| a.date <=> b.date}
    if ((params[:stat] == "bodyweight" && @user.has_bodyweight?) ||
        @user.has_exercise?(params[:stat]))
      @graph_title = params[:stat]
      @stats = params[:stat] == "bodyweight" ? make_bodyweight_stats(@workouts) : make_lift_stats(@workouts, params[:stat])
    else
      redirect_to user_workouts_url
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

    def make_bodyweight_stats(workouts)
      stats = []
      workouts.each do |workout|
        stats.push(format_for_highcharts(workout.date,workout.bodyweight.to_f)) if workout.bodyweight
      end
      return stats
    end
    
    def make_lift_stats(workouts, lift)
      stats = []
      workouts.each do |workout|
        if workout.find_exercise_by_name(lift) and workout.find_exercise_by_name(lift).average_work_weight
          stats.push(format_for_highcharts(workout.date, 
                                           workout.find_exercise_by_name(lift).average_work_weight))
        end
      end
      return stats
    end

    def format_for_highcharts(date,stat)
      ["Date.UTC(#{date.year},#{date.month-1},#{date.day})",stat]
    end

    def correct_user
      user = User.find(params[:user_id])
      redirect_to root_path unless current_user?(user)
    end
end
