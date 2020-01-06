Rails.application.routes.draw do
  root 'root#index'

  resources :users
  resources :posts

  resources :posts do
    member do
      post :like
    end
  end

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
