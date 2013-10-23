Dylanthedog::Application.routes.draw do

  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :posts, only: [:index, :new, :create, :show]

  resource :session, only: [:new, :create, :destroy]

  resources :votes, only: [:index, :show]
  get '/votes/:id_1/:id_2', to: 'votes#index'

  root 'static#index'

 
end
