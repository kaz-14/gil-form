Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  resources :tweets do
    collection do
      get 'confirm'
    end
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: [:index, :edit, :update, :show] do
    resources :relationships, only: [:create, :destroy]
  end
  resources :groups do
    resources :group_tweets, only: [:new, :create, :index, :show]
  end
  
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
end