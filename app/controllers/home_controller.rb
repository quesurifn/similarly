require "base64"

class HomeController < ApplicationController
  def index; end

  def results
    encoded = params['query']

    if encoded.nil?
      raise :bad_request
    end

    decoded = Base64.decode64(params['query'])

    @results = Query.where(query: encoded).first

    if @results
      @results = @results.songs
    end

    unless @results
      similar = helpers.get_similar_tracks(decoded)

      if similar['similartracks']['track'].length == 0
        return redirect_to '/?oops=true'
      end

      @results = helpers.convert_to_spotify(similar)

      # Cache indefinitely
      query = Query.create(query: encoded)

      @results.each do |song|
        s = Song.find_or_create_by(song)
        query.songs << s
      end

      @results = query.songs

    end

    @results
  end
end
