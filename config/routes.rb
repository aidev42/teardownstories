Rails.application.routes.draw do
  devise_for :users
  # adding posts
  resources :posts

  root 'posts#index'
end
