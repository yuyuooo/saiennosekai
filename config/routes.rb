Rails.application.routes.draw do

  resources :plans, only:[:index, :create]

  root to: 'homes#top'
  resources :crop_folders, only: [:index, :show, :create] do
    resources :diaries, only: [:create, :edit, :destroy]
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
