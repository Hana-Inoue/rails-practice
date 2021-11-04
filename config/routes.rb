Rails.application.routes.draw do
  get 'static_pages/about_logs'
  resources :users

  root 'users#index'
end
