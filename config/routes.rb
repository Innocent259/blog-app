Rails.application.routes.draw do
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:index, :show, :new, :create]
      resources :likes, only: [:index, :show, :new, :create], controller: 'post_likes'
    end
  end
end
