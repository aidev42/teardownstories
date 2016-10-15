Rails.application.routes.draw do
  devise_for :users
  # adding posts
  resources :posts do
    member do
      get "upvote", to: "posts#upvote"
    end
    resources :comments
  end

  root 'posts#index'
end
