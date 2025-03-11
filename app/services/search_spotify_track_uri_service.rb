class SearchSpotifyTrackUriService < ApplicationService
  include Api::Request

  BASE_URL = 'https://api.spotify.com/v1'

  def initialize(user, name:, artist: '', album: '')
    @name = CGI.escape(name)
    @artist = CGI.escape(artist)
    @album = CGI.escape(album)
    @access_token = user.spotify_token
  end

  def call
    url = "#{BASE_URL}/search?q=track=#{@name}&artist=#{@artist}&album=#{@album}&type=track&limit=1"
    headers = { 'Authorization' => "Bearer #{@access_token}" }
    response = request(:get, url, headers:)
    response.parsed_response.dig('tracks', 'items', 0, 'uri')
  end
end
