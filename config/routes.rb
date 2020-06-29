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
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
  end

  resources :groups do
    resources :group_tweets do
      collection do
        get 'confirm'
      end
      collection do
        get 'search'
      end
      resources :opinions, only: :create
    end
  end
  
  resources :tasks
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
end