  Rails.application.routes.draw do

  get 'group/create'
  post 'group/create', to: 'group#create_post'

  # Email confirmation
  get 'confirmation/:confirm_token', to: 'sessions#confirm'

  get 'group/view/:groupcode', to: 'group#view'
  get 'group/view/:groupcode/overview', to: 'group#view'

  get 'group/view/:groupcode/administrate', to: 'group#administrate'

  post 'group/edit/:groupcode/members', to: 'group#edit_members'

  # Tascas
  get 'group/create/:groupcode/task', to: 'task#create'
  post 'task/create/', to: 'task#create_post'

  get 'task/view/:taskcode', to: 'task#view'
  get 'task/view/:taskcode/completed', to: 'task#completed'

  # Category
  get 'group/create/:groupcode/category', to: 'category#create'
  post 'category/create', to: 'category#create_post'

  post 'groupinvite/', to: 'group#invite_post'

  get 'acceptinvite/:id', to: 'group#accept_invite'
  get 'denyinvite/:id', to: 'group#deny_invite'

  # Sortir del grup
  get 'group/exit/:groupcode', to: 'group#exit_group_confirm'
  post 'group/exit', to: 'group#exit_group'

  get 'group/delete/:groupcode', to: 'group#delete_group_confirm'
  post 'group/delete', to: 'group#delete_group'
  ###

  get 'admin', to: 'dashboard#admin_dashboard'

  get 'news', to: 'home#news'
  get 'contact', to: 'home#contact'

  get 'groups', to: 'home#groups'
  get 'tasks', to: 'home#tasks'
  get 'calendar', to: 'home#calendar'

  get 'login', to: 'sessions#login_view'
  post 'login', to: 'sessions#create'

  get 'notifications', to: 'home#notifications'
  get 'notifications/delete/:id', to: 'home#delete_notification'
  get 'notifications/accept/:id', to: 'home#accept_notification'

  get 'register', to: 'sessions#register_view'
  post 'register', to: 'sessions#register'

  get 'profile/:user', to: 'profile#view_view'

  get 'editprofile', to: 'profile#edit_view'
  post 'editprofile', to: 'profile#edit'

  get 'logout', to: 'sessions#logout'
  root to: 'home#index'
  # Api routes

  end
