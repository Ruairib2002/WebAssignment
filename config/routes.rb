Rails.application.routes.draw do
  get 'gps/index'
  get 'gps/new_route', to: 'gps#new_route', as: 'new_route'
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  get 'profile/:id', to: 'profiles#show', as: 'profile'
  get 'profile/:id/edit', to: 'profiles#edit', as: 'edit_profile'
  patch 'profile/:id', to: 'profiles#update', as: 'update_profile'

  get 'search', to: 'profiles#search', as: 'search'

  resources :groups do
    resources :messages, only: [:index, :create, :new]
    resources :assignments, only: [:index, :new, :create, :show] do
      post 'assign_marks/:assignment_id', on: :member, to: 'assignments#assign_marks', as: 'assign_marks'
    end
    member do
      post 'add_student'
      delete 'remove_student'
      post 'upload_file'
    end
    collection do
      get 'search'
    end
  end

  get 'gps', to: 'gps#index', as: 'gps'
  post 'gps/report_issue', to: 'gps#report_issue', as: 'report_issue'

  resources :messages, only: [:new, :create]

  get 'admin/panel', to: 'admin#panel', as: 'admin_panel'
  get 'admin/password', to: 'admin#new_password', as: 'new_admin_password'
  post 'admin/authenticate_password', to: 'admin#authenticate_password', as: 'authenticate_admin_password'
  get 'admin/manage_roles', to: 'admin#manage_roles', as: 'admin_manage_roles'
  patch 'admin/update_role/:id', to: 'admin#update_role', as: 'admin_update_role'

  get 'admin/users', to: 'admin#users_index', as: 'admin_users'
  get 'admin/users/:id/edit', to: 'admin#edit_user', as: 'edit_admin_user'
  patch 'admin/users/:id', to: 'admin#update_user', as: 'update_admin_user'

  get 'admin/groups', to: 'admin#groups_index', as: 'admin_groups'
  get 'admin/groups/:id/edit', to: 'admin#edit_group', as: 'edit_admin_group'
  patch 'admin/groups/:id', to: 'admin#update_group', as: 'update_admin_group'

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :groups, only: [:index, :show, :edit, :update, :destroy]
  end

  resources :routes, only: [:create]
  resources :places, only: [:show]
  resources :issues
end
