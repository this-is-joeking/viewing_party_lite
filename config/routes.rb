# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/dashboard', to: 'users#show'

  
  resources :users, only: :create

  resources :movies, only: %i[index show] do
    resources :viewing_party, only: %i[new create show]
  end

  get '/admin/dashboard', to: 'admin/users#index'
  namespace :admin do
    resources :users, only: :show
  end
  
  resources :discover, only: :index
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout_user'

  get '/register', to: 'users#new'
end
