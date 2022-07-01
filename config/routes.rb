Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users

  root to: 'homes#top'
  resources :crop_folders, only: [:index, :show, :create, :edit, :update, :destroy] do
    resources :diaries, only: [:create, :destroy]
    resources :crop_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    resource :plans, only:[:show, :create]
  end

  resources :users, only: [:index, :show, :edit, :update]
  resources :items, only: [:index, :show, :create, :edit, :update, :destroy] do
    resource :likes, only: [:create, :destroy]
  end

  get 'users/:id/about', to: 'users#about', as: 'user_about'
  get 'users/:id/favorites', to: 'users#favorites', as: 'user_favorites'
  get 'users/:id/likes', to: 'users#likes', as: 'user_likes'
  get 'users/:id/items', to: 'users#items', as: 'user_items'

  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  resources :notifications, only: [:index] do
    collection do
      delete 'destroy_all'
    end
  end

end
