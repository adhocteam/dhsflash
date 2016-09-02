Rails.application.routes.draw do
  devise_for :users

  resources :kudos, only: [:index, :create] do
    resources :thumbs_ups, only: [:create]
  end

  resource :dashboard, only: [:show], controller: 'dashboard'

  get '/users/search', to: 'users#search'
  get '/users/:id', to: 'users#show', as: :user

  get '/help', to: 'home#help'

  root 'home#show'

  namespace :admin do
    resources :users, only: [:index, :destroy] do
      patch 'make_admin', on: :member
      patch 'remove_admin', on: :member
      patch 'toggle_user', on: :member
    end
  end
end
