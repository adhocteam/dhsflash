Rails.application.routes.draw do
  devise_for :users

  resources :kudos, only: [:create]

  root 'home#show'

  namespace :admin do
    resources :users, only: [:index, :destroy] do
      patch 'make_admin', on: :member
      patch 'remove_admin', on: :member
    end
  end
end
