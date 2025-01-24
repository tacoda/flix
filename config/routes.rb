Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :genres
  root "movies#index"

  get "movies/filter/:filter" => "movies#index", as: :filtered_movies

  resources :movies do
  	resources :reviews
  	resources :favorites, only: [:create, :destroy]
  end

  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"

  resources :users
  get "signup" => "users#new"
end
