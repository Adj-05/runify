Rails.application.routes.draw do
  resources :playlists, only:[:show, :index, :destroy]
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :trainings, only: [ :new, :create, :show, :index]
  get 'trainings/:user_id', to: 'trainings#index', as: 'user_trainings'


end
