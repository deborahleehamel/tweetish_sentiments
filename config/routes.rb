Rails.application.routes.draw do
  root "home#index"

  get "/auth/twitter", as: :twitter_login
  get "/auth/twitter/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/dashboard", to: "dashboard#show"
  get "/friends", to: "friends#show"
  get "/tweets", to: "users#show", as: :tweets
  get "/friend_tweets", to: "users#show_friend_tweets", as: :friend_tweets
  # get "/byhandle_tweets", to: "byhandle#show_handle_tweets", as: :byhandle_tweets
  # get "/turing_tweets", to: "turing#show", 
end
