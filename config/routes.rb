Rails.application.routes.draw do
  # Custom route for health check (not related to search, just keep it as is)
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'home#index'

  devise_for :users

  # Routes for user profile
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'profile', to: 'profiles#show', as: 'profile'
  get 'profile/edit', to: 'profiles#edit', as: 'edit_profile'
  patch 'profile', to: 'profiles#update'
  put 'profile', to: 'profiles#update'

  # Routes for groups and messages
  resources :groups do
    resources :messages, only: [:index, :create]

    # Routes for adding/removing students from groups
    member do
      post 'add_student'
      delete 'remove_student'
    end

    # Collection-level route for searching groups (if necessary)
    collection do
      get 'search'  # This is for the search action in your SearchController
    end
  end

  # Search route for searching students and groups
  get 'search', to: 'search#index', as: 'search'  # The actual search path
end
