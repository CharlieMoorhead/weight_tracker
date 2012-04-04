WeightTracker::Application.routes.draw do
	resources :workouts, :except => [:show]

	root :to => 'workouts#index'
end
