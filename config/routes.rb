SocialThingamajig::Application.routes.draw do
  resources :users, only: [:new, :create, :index]

  resource :session, only: [:new, :create, :destroy]

  resource :reset_password, only: [:new, :create, :edit, :update]

  root to: 'users#index'
end
