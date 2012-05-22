Factory.define :exercise_set do |set|
	set.reps	5
	set.weight 	150
end

Factory.define :exercise do |exercise|
	exercise.name "squat"
end

Factory.define :workout do |workout|
	workout.date					 Date.today
	workout.bodyweight				150.5
	workout.note					"First workout"
end

Factory.define :user do |user|
  user.username "example"
  user.email "hi@example.com"
  user.password "foobar"
end

Factory.sequence :date do |n|
	Date.today + n
end

Factory.sequence :bodyweight do |n|
	100 + n
end

Factory.sequence :username do |n|
  "Example #{n}"
end

Factory.sequence :email do |n|
  "Ex-#{n}@example.com"
end
