WeightTracker::Application.routes.draw do
  get "workouts/new"

  get "workouts/show"

	resources :workouts
end
