Factory.define :exercise_set do |set|
	set.reps	5
	set.weight 	150
end

Factory.define :exercise do |exercise|
	exercise.name "squat"
end

Factory.define :workout do |workout|
	workout.date		 Date.today
	workout.bodyweight	150.5
	workout.note		"First workout"
end
