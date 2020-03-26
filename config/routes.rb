Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/auth/spotify/callback', to: 'application_controller#index'
  get '/spotify/search', to: 'spotify_controller#search'
  get '/success', to: 'spotify_controller#success'
  post '/spotify/add_playlist', to: 'spotify_controller#create_playlist'

end
