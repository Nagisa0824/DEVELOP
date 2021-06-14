Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  
  resources :posts do
  resource :favorites, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
 end
 
 resources :users,only: [:show,:index,:edit,:update] do
  resource :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'
 end 
end
