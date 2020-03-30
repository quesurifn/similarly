require "base64"

class HomeController < ApplicationController
  def index; end

  def results
    encoded = params['query']
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

      ## TODO FIND OR CREATE
      query.songs.create(result)
    end

    @results
  end
end
