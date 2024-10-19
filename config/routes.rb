Rails.application.routes.draw do
  resources :sales, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Health check endpoint
  get 'health_check', to: 'health_checks#show'
end
