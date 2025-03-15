Rails.application.routes.draw do
  resources :playlists, only:[:show, :index, :destroy]
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
 # resources :trainings, only: [ :new, :create, :show]
  #get "trainings/:id/preview", to: "trainings#preview", as: :preview_training

  resources :trainings do
    member do
      get 'preview' #affiche page preview
      post 'confirm' #action pour confirmer la session
    end
  end


end
