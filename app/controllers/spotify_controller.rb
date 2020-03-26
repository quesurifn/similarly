require 'rspotify'

class SpotifyController < ApplicationController

  def create_playlist
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    tracks = params['tracks']
    playlist_template = "Smilarl To: #{params['original_song_name']}"
    playlist = spotify_user.create_playlist!(playlist_template)

    tracks_to_add = []
    tracks.each do |track|
      query = "#{track['name']} #{track['artist']}"
      tracks = RSpotify::Track.search(query)
      tracks_to_add << tracks.first
    end

    playlist.add_tracks!(tracks_to_add)

    redirect_to "/success"
  end

  def search
    client_id = Rails.application.credentials.spotify[:client_id]
    client_secret = Rails.application.credentials.spotify[:client_secret]
    RSpotify.authenticate(client_id, client_secret)
    RSpotify::Track.search(params['query'])
  end

  def success
    render 'success'
  end

end
