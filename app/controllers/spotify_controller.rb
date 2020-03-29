require 'rspotify'

class SpotifyController < ApplicationController

  def create_playlist
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    tracks = params['tracks']
    playlist_template = "Similarly To: #{params['original_song_name']}"
    playlist = spotify_user.create_playlist!(playlist_template)

    tracks_to_add = []
    tracks.each do |track|
      query = "#{track['name']} #{track['artist']}"
      tracks = RSpotify::Track.search(query)
      tracks_to_add << tracks.first
    end

    playlist.add_tracks!(tracks_to_add)
  end

  def search
    client_id = Rails.application.credentials.spotify[:client_id]
    client_secret = Rails.application.credentials.spotify[:client_secret]
    RSpotify.authenticate(client_id, client_secret)
    results = RSpotify::Track.search(params['query'])

    parsed = []
    results.each do |song|
      parsed << {title: "#{song.name} - #{song.artists[0].name}", image: song.album.images[0]['url']}
    end

    render json: parsed
  end
end
