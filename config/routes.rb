Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :sales, only: [:show]
  resources :organization_reports, only: [:show]

  # Health check endpoint
  get 'health_check', to: 'health_checks#show'
end
