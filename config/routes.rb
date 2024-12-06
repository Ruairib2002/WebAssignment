Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'profile/:id', to: 'profiles#show', as: 'profile'
  get 'profile/edit', to: 'profiles#edit', as: 'edit_profile'
  patch 'profile', to: 'profiles#update'
  put 'profile', to: 'profiles#update'
  get 'search', to: 'profiles#search', as: 'search'

  resources :groups do
    resources :messages, only: [:index, :create, :new]  # Added :new route here
    member do
      post 'add_student'
      delete 'remove_student'
      post 'upload_file'
    end
    collection do
      get 'search'
    end
  end

  resources :messages, only: [:new, :create]

  get 'admin/panel', to: 'admin#panel', as: 'admin_panel'

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :groups, only: [:index, :show, :edit, :update, :destroy]
  end
end
