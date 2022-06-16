Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  root to: 'homes#top'
  resources :crop_folders, only: [:index, :show, :create] do
    resources :diaries, only: [:create, :edit, :destroy]
    resource :plans, only:[:index, :show, :create]
  end

  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]
  get 'users/:id/about', to: 'users#about',as: 'user_about'

end
