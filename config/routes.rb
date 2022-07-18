Rails.application.routes.draw do
  root "games#index"

  resources :words, only: [:index, :show]
  resources :games
  resources :guesses
  # resources :games do
  #   resources :guesses
  # end
end
