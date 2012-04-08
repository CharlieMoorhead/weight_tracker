namespace :db do
	desc "Fill database with data from a file"
	task :load_data_from_file => :environment do
		Rake::Task['db:reset'].invoke
	  load_data
	end
end

def load_data
  columns = ["date",#0
             "squat",#1
             "bench",#2
             "ups",#3
             "press",#4
             "deadlift",#5
             "weight",#6
             "notes"#7
  ]

  if File.file?("data.csv")
    file = File.open("data.csv")
    file.each do |line|
      d = line.gsub("\n","").split(",")
      date = Date.strptime(d[0],"%m/%d/%Y")
      bodyweight = d[6].to_i == 0 ? nil : d[6].to_i

      workout = Workout.create!(:date => date, :bodyweight => bodyweight, :note => d[7])

      add_exercise(workout, "Squat", d[1]) unless d[1].to_i == 0
      add_exercise(workout, "Bench", d[2]) unless d[2].to_i == 0
      add_exercise(workout, "Ups", d[3]) unless d[3].to_i == 0
      add_exercise(workout, "Press", d[4]) unless d[4].to_i == 0
      add_exercise(workout, "Deadlifts", d[5]) unless d[5].to_i == 0
    end
  end
end

def add_exercise(workout, name, weight)
  exercise = workout.exercises.create!(:name => name)
  exercise.exercise_sets.create!(:reps => 5, :weight => weight)
end
