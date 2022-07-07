Rails.application.routes.draw do
  # root "words#index"

  get '/words', to: 'words#index'
end
