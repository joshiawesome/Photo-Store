Rails.application.routes.draw do
  # Other routes ...

  # products routes
  # Route /products to ProductsController#index
  resources :products, only: [:index]
  # Route /products/import to ProductsController#import
  post "products/import", to: "products#import"

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