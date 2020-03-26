require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  client_id = Rails.application.credentials.spotify[:client_id]
  client_secret = Rails.application.credentials.spotify[:client_secret]
  provider :spotify, client_id, client_secret, scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end