  Rails.application.routes.draw do

    root to: 'home#index'
    # Api routes
    post 'api/user/register', to: 'api#register'
    post 'api/user/login', to: 'api#login'
  end
