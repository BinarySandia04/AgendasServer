  Rails.application.routes.draw do
    # resources :users # NOOOOOOOOOOOOO
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    post 'api/user/register', to: 'account#register'
    post 'api/user/login', to: 'account#login'
  end
