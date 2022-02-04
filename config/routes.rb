Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'static_pages/about_activerecord_logs'
  get 'static_pages/about_server_logs'
  get 'static_pages/search_functions_summary'

  resources :users do
    resource :authorizations, only: [:edit, :update]
    resource :user_address, only: [:edit, :update, :destroy]
    resources :user_diaries
  end

  resources :user_posts, except: :show do
    resources :user_post_comments, only: [:index, :create, :destroy]
  end

  resources :events do
    collection do
      get :search
    end
  end

  resources :todos, only: :index do
    collection do
      get :search
    end
  end

  resources :schedules do
    collection do
      get :search
      get :sql_injection_search
    end
  end

  resources :shops, only: [:index]

  resources :products, only: [:index] do
    member do
      post :add_product_to_cart
    end
    collection do
      get :show_cart
    end
  end

  root 'users#index'
end
