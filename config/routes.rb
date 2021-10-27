Rails.application.routes.draw do

   get 'search' => 'posts#search'
   get 'sort' => 'posts#sort'
   resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  devise_for :users

  root 'homes#top'

  get '/users/awin' => 'users#awin'
  get '/users/search' => 'users#search', as: 'user_search'
  resources :users,only: [:show,:index,:edit,:update] do
      member do
      resources :favorites, only: [:index]
      end
    resource :relationships, only: [:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'

  end





end

