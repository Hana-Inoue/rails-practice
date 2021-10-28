Rails.application.routes.draw do
  get 'static_pages/logs'
  resources :users

  root 'users#index'
end
