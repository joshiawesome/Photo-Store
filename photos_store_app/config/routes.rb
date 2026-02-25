Rails.application.routes.draw do
  # Other routes ...

  # Route /photos to PhotosController#index
  resources :photos, only: [:index]

  # Optional: root path
  root "photos#index"

  # Route /photos/import to PhotosController#import
  post "photos/import", to: "photos#import"
end