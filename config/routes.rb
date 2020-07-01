  Rails.application.routes.draw do

    get 'news', to: 'home#news'
    get 'contact', to: 'home#contact'

  get 'login', to: 'sessions#login_view'
  post 'login', to: 'sessions#create'

  get 'register', to: 'sessions#register_view'
  post 'register', to: 'sessions#register'

  get 'profile/:profile', to: 'profile#view_view'

  get 'editprofile', to: 'profile#edit_view'
  post 'editprofile', to: 'profile#edit'

  get 'logout', to: 'sessions#logout'
  root to: 'home#index'
  # Api routes

  end
