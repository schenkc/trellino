SocialThingamajig::Application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    resources :friend_circles, only: [:show]
  end

  resources :friend_circles, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  resource :session, only: [:new, :create, :destroy]

  resource :reset_password, only: [:new, :create, :edit, :update]

  resources :posts do
    resources :links, shallow: :true
  end

  get "/feed" => "posts#feed"

  root to: 'users#show'
end
