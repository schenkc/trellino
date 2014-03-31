SocialThingamajig::Application.routes.draw do
  resources :users, only: [:new, :create, :index] do
    resources :friend_circles, only: [:show]
  end

  resources :friend_circles, only: [:new, :create, :index, :destroy]

  resource :session, only: [:new, :create, :destroy]

  resource :reset_password, only: [:new, :create, :edit, :update]

  root to: 'users#show'
end
