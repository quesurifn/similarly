require 'net/http'
require 'rspotify'

module HomeHelper
  def get_similar_tracks(query)
    key = Rails.application.credentials.lastfm[:key]
    param_array = query.split('-')
    track = param_array[0].strip
    artist = param_array[1].strip

    base = "http://ws.audioscrobbler.com/2.0/"
    query = URI.encode_www_form(
        "method" => "track.getsimilar",
        "artist" => artist,
        "track" => track,
        "api_key" => key,
        "format" => "json"
    )

    uri = URI("#{base}?#{query}")

    result = Net::HTTP.get(uri)
    JSON.parse(result)
  end

  def get_duration_hrs_and_mins(milliseconds)o
    hours, milliseconds   = milliseconds.divmod(1000 * 60 * 60)
    minutes, milliseconds = milliseconds.divmod(1000 * 60)
    seconds, milliseconds = milliseconds.divmod(1000)
    "#{hours}h #{minutes}m #{seconds}s #{milliseconds}ms"
  end

  def convert_to_spotify(last_fm)
    client_id = Rails.application.credentials.spotify[:client_id]
    client_secret = Rails.application.credentials.spotify[:client_secret]
    RSpotify.authenticate(client_id, client_secret)
    spotify_tracks = []

    # cut array for performance
    results = last_fm['similartracks']['track'].slice(0, 10)

    results.each_with_index do |song, idx|
      puts "#{idx + 1} of #{last_fm['similartracks']['track'].length}"
      query = "#{song['name']} #{song['artist']['name']}"
      tracks = RSpotify::Track.search(query)
      spotify_tracks << tracks.first
    end

    parsed = parse_spotify_results(spotify_tracks)
    parsed
  end

  def parse_spotify_results(obj)
    parsed_results = []
    obj.each_with_index do |song, idx|
      song = song.as_json
      if song['artists']
        artists = song['artists'].map {|artist| artist['name'] }.join(',')
        parsed_results << {title: song['name'], artist: artists, uri: song['uri'], preview_link: song['preview_url'], image_uri: song['album']['images'][1]['url'], explicit: song['explicit'], popularity: song['poplularity'] }
      end
    end
    parsed_results
  end
end
