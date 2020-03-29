Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'
  get  '/results', to: 'home#results'

  get '/auth/spotify/callback', to: 'home#index'
  get '/spotify/search', to: 'spotify#search'
  post '/spotify/add_playlist', to: 'spotify#create_playlist'

end
