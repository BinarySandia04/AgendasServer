  Rails.application.routes.draw do

  get 'group/create'
  post 'group/create', to: 'group#create_post'

  get 'group/view/:groupcode', to: 'group#view'

  get 'group/join', to: 'group#join'
  post 'group/join', to: 'group#join_post'

  get 'admin', to: 'dashboard#admin_dashboard'

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
