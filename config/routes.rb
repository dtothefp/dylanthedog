Dylanthedog::Application.routes.draw do

  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :posts, only: [:index, :new, :create, :show]

  resource :session, only: [:new, :create, :destroy]

  resources :votes, only: [:new, :create]

  root 'static#index'

 
end
