Rails.application.routes.draw do
  devise_for :users
  root "artists#index"

  resources :artists, :songs
  get "bootstrap", to: "artists#bootstrap"



end
