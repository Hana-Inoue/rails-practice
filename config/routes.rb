Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'static_pages/about_server_logs'
  get 'static_pages/about_activerecord_logs'
  resources :users

  root 'users#index'
end
