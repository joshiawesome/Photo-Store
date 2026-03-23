Rails.application.routes.draw do
  # Other routes ...

  # photos routes
  # Route /photos to PhotosController#index
  resources :photos, only: [:index]
  # Route /photos/import to PhotosController#import
  post "photos/import", to: "photos#import"

  # users routes
  resources :users, only: [:create]

  # sessions routes
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Optional: root path
  root "photos#index"
end