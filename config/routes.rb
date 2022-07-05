Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :edit, :update, :show]
    resources :crop_folders, only: [:index, :show, :destroy] do
      resources :diaries, only: [:destroy]
      resources :crop_comments, only: [:destroy]
    end
    resources :items, only: [:index, :destroy]
    get 'users/:id/items', to: 'users#items', as: 'user_items'
    resources :month_crops, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end

  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  root to: 'homes#top'
  get '/month_crop', to: 'homes#month_crop', as: 'month_crop'
  resources :crop_folders, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
    resources :diaries, only: [:new, :create, :destroy]
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
  get 'users/:id/quit' => 'users#quit', as: 'quit'
  patch 'users/:id/out' => 'users#out', as: 'out'

  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  get "search" => "searches#search_result"

  resources :notifications, only: [:index] do
    collection do
      delete 'destroy_all'
    end
  end

end
