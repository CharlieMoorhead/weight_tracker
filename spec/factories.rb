Factory.define :repetition do |rep|
	rep.weight 100
	rep.amount 5
end

Factory.define :exercise_set do |set|
end

Factory.define :exercise do |exercise|
	exercise.name "squat"
end

Factory.define :workout do |workout|
	workout.date		 Date.today
	workout.bodyweight	150.5
	workout.note		"First workout"
end
