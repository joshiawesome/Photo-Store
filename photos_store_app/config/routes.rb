Rails.application.routes.draw do
  # Other routes ...
  # routes can also be organized as collections

  # products routes
  # Route /products to ProductsController#index
  resources :products, only: [:index]
  post "products/import", to: "products#import"
  get "products/search", to: "products#search"
  get "products/filter", to: "products#filter"

  # users routes
  resources :users, only: [:create]
  post   "/signup",  to: "users#create"

  # sessions routes
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get    "/session", to: "sessions#show"

  # Optional: root path
  root "products#index"
end