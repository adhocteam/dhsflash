Rails.application.routes.draw do
  devise_for :users

  root 'home#show'

  namespace :admin do
    resources :users, only: [:index] do
      patch 'make_admin', on: :member
    end
  end
end
