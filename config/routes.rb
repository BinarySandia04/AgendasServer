  Rails.application.routes.draw do

  get 'group/create'
  post 'group/create', to: 'group#create_post'

  # Email confirmation
  get 'confirmation/:confirm_token', to: 'sessions#confirm'

  get 'group/view/:groupcode/overview', to: 'group#view'

  get 'group/view/:groupcode/invitations', to: 'group#invite'
  post 'group/view/:groupcode/invitations', to: 'group#invite_post', as: 'group_invite'

  get 'group/search', to: 'group#join', as: 'group_join'
  post 'group/search', to: 'group#join_post'

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
