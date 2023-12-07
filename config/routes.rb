Rails.application.routes.draw do
  get 'stimulus/navbar-link-votes'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "dashboard", to: "pages#dashboard"
  # Defines the root path route ("/")
  # root "posts#index"

  resources :events do
    resources :event_places, only: [:index, :create]
  end

  resources :event_places, only: [:index, :show] do
    member do
      get "vote", to: "event_places#vote"
    end
  end

  resources :groups, only: [:index, :new, :create]

  get 'notifications', to: 'notifications#index'
end
