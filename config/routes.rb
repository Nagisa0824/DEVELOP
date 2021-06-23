Rails.application.routes.draw do
  get 'favorite_users/index'
  get 'finders/finder'
  get 'chats/show'
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  get 'finder' => "finders#finder"

  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  
  resources :notifications, only: [:index]

  resources :posts do
  resource :favorites, only: [:create, :destroy,:show]
  resources :post_comments, only: [:create, :destroy]
  resources :favorite_users,only: [:index]
 end

 resources :users,only: [:show,:index,:edit,:update] do
  resource :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'
 end
end
