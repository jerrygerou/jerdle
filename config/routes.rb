Rails.application.routes.draw do
  # root "words#index"

  get '/words', to: 'words#index'
  get '/games/:id', to: 'games#show'
end
