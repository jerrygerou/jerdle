Rails.application.routes.draw do
  root "games#index"
  resources :words, only: [:index, :show]
  # resources :games, only: [:show, :create]
  resources :games
  resources :guesses
end
