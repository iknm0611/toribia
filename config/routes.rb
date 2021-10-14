Rails.application.routes.draw do

   resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  devise_for :users
  root 'homes#top'

  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

end

