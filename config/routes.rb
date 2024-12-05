Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'home#index'

  devise_for :users

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'profile', to: 'profiles#show', as: 'profile'
  get 'profile/edit', to: 'profiles#edit', as: 'edit_profile'
  patch 'profile', to: 'profiles#update'
  put 'profile', to: 'profiles#update'

  resources :groups do
    resources :messages, only: [:index, :create]

    # Member routes for actions like adding and removing students
    member do
      post 'add_student'
      delete 'remove_student'
      post 'upload_file'  # Add this for file upload functionality
    end

    # Collection routes for searching groups
    collection do
      get 'search'
    end
  end

  get 'search', to: 'search#index', as: 'search'
end
