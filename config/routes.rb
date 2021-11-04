Rails.application.routes.draw do
  get 'static_pages/about_rails_logs'
  get 'static_pages/about_activerecord_logs'
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  root 'users#index'
end
