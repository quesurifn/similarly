require 'lastfm'

class LastFmController < ApplicationController
  def find_similar
    key = Rails.application.credentials.lastfm[:key]
    secret = Rails.application.credentials.lastfm[:secret]
    lastfm = Lastfm.new(key, secret)
    token = lastfm.auth.get_token
    lastfm.session = lastfm.auth.get_session(token: token)['key']

    lastfm.track.getSimilar(params['query'])
  end
end
