Rails.application.routes.draw do
  get 'home/index'

  resources :stats, only: [:show]
  resources :events, only: [:create]
  resources :users, only: [:create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
end
