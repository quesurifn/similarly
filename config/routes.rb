Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'
  get  '/results', to: 'home#results'

  get '/spotify/search', to: 'spotify#search'
  get '/auth/spotify/callback', to: 'spotify#callback'
  post '/spotify/create_playlist', to: 'spotify#create_playlist'
end
