WeightTracker::Application.routes.draw do
	resources :workouts, :except => [:show]
	resources :users
	resources :sessions, :only => [:new, :create, :destroy]

	match 'workouts/graph' => 'workouts#graph'

	match '/signup', :to => 'users#new'
	match '/signin', :to => 'sessions#new'
	match '/signout', :to => 'sessions#destroy'

	root :to => 'workouts#index'
end
