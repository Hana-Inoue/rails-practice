Rails.application.routes.draw do
  get 'static_pages/about_server_logs'
  get 'static_pages/about_activerecord_logs'
  resources :users

  root 'users#index'
end
