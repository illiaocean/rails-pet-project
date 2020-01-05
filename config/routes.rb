Rails.application.routes.draw do
  root 'root#index'

  resources :users
  resources :posts

  get 'signup', to: 'users#new'
end
