WeightTracker::Application.routes.draw do
	resources :workouts, :except => [:show]

	match ':workouts/graph' => 'workouts#graph'

	root :to => 'workouts#index'
end
