class CreateSpotifyPlaylistService < ApplicationService
  include Api::Request

  BASE_URL = 'https://api.spotify.com/v1'

  attr_reader :name, :track_ids, :description

  def initialize(user, name, tracks_infos, description: 'Created by Spotify Playlist Generator')
    @user = user
    @name = name
    @tracks_infos = tracks_infos
    @description = description
    @access_token = user.spotify_token
    @user_spotify_id = user.spotify_id
    @tracks_spotify_uris = deezer_infos_to_spotify_uris
  end

  def call
    playlist = create_playlist
    playlist_id = playlist['id']

    add_tracks_to_playlist(playlist_id)

    get_playlist(playlist_id)
  end

  private

  def deezer_infos_to_spotify_uris
    @tracks_infos.map do |track_infos|
      SearchSpotifyTrackUriService.call(@user, name: track_infos[:title], album: track_infos[:album], artist: track_infos[:artist])
    end
  end

  def create_playlist
    url = "#{BASE_URL}/users/#{@user_spotify_id}/playlists"
    body = { name:, description:, public: true }

    request_with_auth(:post, url, body:)
  end

  def add_tracks_to_playlist(playlist_id)
    url = "#{BASE_URL}/playlists/#{playlist_id}/tracks"
    body = { uris: @tracks_spotify_uris }

    request_with_auth(:post, url, body:)
  end

  def get_playlist(playlist_id)
    url = "#{BASE_URL}/playlists/#{playlist_id}"

    request_with_auth(:get, url)
  end

  def request_with_auth(method, url, body: nil)
    headers = { 'Authorization' => "Bearer #{@access_token}" }

    request(method, url, headers:, body:).parsed_response
  end
end
