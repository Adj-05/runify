Rails.application.routes.draw do
  get 'playlists/index'
  get 'playlists/show'
  get 'playlists/destroy'
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :trainings, only: [ :new, :create]


end
