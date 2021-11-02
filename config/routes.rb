Rails.application.routes.draw do
  get 'static_pages/about_logs'
  get 'static_pages/about_activerecord'
  resources :users

  root 'users#index'
end
