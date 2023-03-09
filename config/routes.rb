Rails.application.routes.draw do

  devise_scope :user do
    get "/signup", to: 'users/registrations#new'
    get "/login", to: 'users/sessions#new'
  end
  devise_for :users
  get "home", to: "pages#home"
  root "pages#welcome"
  get "display", to: "users/display#index"
  post "send_friend_request", to: "users/display#send_friend_request"
  post "accept_friend_request", to: "users/display#accept_friend_request"
  get "friend_requests", to: "users/display#show_friend_request"
  get "friends", to: "users/display#show_friends"
  resources :posts, except: :new 
  get "upload", to: "posts#new"
  get "view", to: "posts#view"
  resources :posts do
    member do
      post 'create_like'
      delete 'destroy_like'
      post 'create_comment'
    end
  end
  resources :friendships, only: :destroy
  
end
