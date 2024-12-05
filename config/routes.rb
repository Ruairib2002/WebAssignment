Rails.application.routes.draw do
  # Health check endpoint for uptime monitoring
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path (home page)
  root to: 'home#index'

  # Devise routes for user authentication (login, registration, etc.)
  devise_for :users

  # Dashboard route (You can adjust the controller name and action if needed)
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  # Profile route for the current user (assuming you have a UsersController with a show action)
  get 'profile', to: 'users#show', as: 'profile'

  resources :groups do
    resources :messages, only: [:index, :create]
  end


  # Routes for Groups (resources handle CRUD operations for groups)
  resources :groups do
    # Nested resources for Messages under a group
    resources :messages, only: [:create, :index]
  end

  # You can add other necessary routes for any other features in your app.
end
