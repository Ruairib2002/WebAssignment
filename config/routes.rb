Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root to: 'home#index'

  devise_for :users

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  # Profile routes
  get 'profile', to: 'profiles#show', as: 'profile'
  get 'profile/edit', to: 'profiles#edit', as: 'edit_profile'
  patch 'profile', to: 'profiles#update'
  put 'profile', to: 'profiles#update'

  resources :groups do
    resources :messages, only: [:index, :create]
  end
end
