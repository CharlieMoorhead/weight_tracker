WeightTracker::Application.routes.draw do
	resources :users, :only => [:new, :create] do
    resources :workouts, :except => [:show] do
      collection do
        get 'graph'
      end
    end
  end
	resources :sessions, :only => [:new, :create, :destroy]

	match '/signup', :to => 'users#new'
	match '/signin', :to => 'sessions#new'
	match '/signout', :to => 'sessions#destroy'

	root :to => 'sessions#new'
end
