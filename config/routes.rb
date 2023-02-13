# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :users, only: %i[create show] do
    resources :discover, only: :index
    resources :movies, only: %i[index show] do
      resources :viewing_party, only: %i[new create show]
    end
  end

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  
  get '/register', to: 'users#new'
end
