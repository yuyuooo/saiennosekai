Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users

  root to: 'homes#top'
  resources :crop_folders, only: [:index, :show, :create] do
    resources :diaries, only: [:create, :edit, :destroy]
    resources :crop_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    resource :plans, only:[:index, :show, :create]
  end

  resources :users, only: [:index, :show, :edit, :update]
  get 'users/:id/about', to: 'users#about', as: 'user_about'
  get 'users/:id/favorites', to: 'users#favorites', as: 'user_favorites'

end
