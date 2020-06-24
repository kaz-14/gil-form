Rails.application.routes.draw do
  # get 'relationships/create'
  # get 'relationships/destroy'
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
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
  end

  resources :groups do
    resources :group_tweets, only: [:new, :create, :index, :show]
  end
  
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
end