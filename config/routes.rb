Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  resources :tweets do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: [:index, :edit, :update, :show]
  resources :groups, only: [:index, :new, :create, :edit, :update, :show]
  # resources :relationships, only: [:create, :destroy]
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
end