require 'rspotify'
require 'ostruct'

class SpotifyController < ApplicationController

  def callback
    query = request.env['omniauth.params']
    cookies[:query] = {value: "#{query['q']}", expires: 20.minutes}
    cookies[:auth]  = {value: request.env['omniauth.auth'].to_json, expires: 20.minutes}
    head :no_content
  end


  def create_playlist
    auth_hash = JSON.parse(params['auth'])
    tracks = params['tracks']
    parsed_tracks = []
    tracks.each do |track|
      parsed_tracks << OpenStruct.new(track)
    end

    spotify_user = RSpotify::User.new(auth_hash)

    playlist_template = "Similarly To: #{params['original_song_name']}"
    playlist = spotify_user.create_playlist!(playlist_template)
    playlist.add_tracks!(parsed_tracks)
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
