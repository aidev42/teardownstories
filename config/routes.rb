Rails.application.routes.draw do
  # adding posts
  resources :posts

  root 'posts#index'
end
