Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'static_pages/about_server_logs'
  get 'static_pages/about_activerecord_logs'

  resources :users do
    resource :authorizations, only: [:edit, :update]
    resource :user_address, only: [:edit, :update, :destroy]
  end

  resources :user_posts, except: :show do
    resources :user_post_comments, only: [:index, :create, :destroy]
  end

  root 'users#index'
end
