namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		make_workouts
	end
end

def make_workouts
	20.times do |n|
		workout = Workout.create!(:bodyweight => 140 + n,
								  :date => Date.today + n)
		make_sets(workout, "squat", 200 + 5*n)
		make_sets(workout, "bench", 100 + 5*n)
		make_sets(workout, "deadlift", 250 + 5*n)
	end
end

def make_sets(workout, name, weight)
	exercise = workout.exercises.create!(:name => name)
	3.times do
		failure = rand(10) == 9 ? true : false
		exercise.exercise_sets.create!(:reps => 5, :weight => weight, :failure => failure)
	end
end
