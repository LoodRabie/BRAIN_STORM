Rails.application.routes.draw do
  devise_for :users

  get "/about", to: "pages#about"
  root to: "brains#index"

  resources :brains do
    resources :bookings, only: [:new, :create, :index, :show, :destroy]
  end

  # Define a custom route for my_bookings action outside the resources :brains block
  resources :bookings do
    collection do
      get 'my_bookings'
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
