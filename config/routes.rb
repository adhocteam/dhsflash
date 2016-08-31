Rails.application.routes.draw do
  devise_for :users

  resources :kudos, only: [:create]

  resource :dashboard, only: [:show], controller: 'dashboard'

  get '/users/search', to: 'users#search'

  root 'home#show'

  namespace :admin do
    resources :users, only: [:index, :destroy] do
      patch 'make_admin', on: :member
      patch 'remove_admin', on: :member
    end
  end
end
