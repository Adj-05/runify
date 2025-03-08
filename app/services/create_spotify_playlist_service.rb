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
    add_tracks_to_playlist(playlist['id'])
    playlist
  rescue StandardError => e
    puts backtrace.join("/n")
  end

  private

  def deezer_infos_to_spotify_uris
    @tracks_infos.map do |track_infos|
      SearchSpotifyTrackUriService.call(@user, name: track_infos[:title], album: track_infos[:album], artist: track_infos[:artist])
    end
  end

  def create_playlist
    url = "#{BASE_URL}/users/#{@user_spotify_id}/playlists"
    headers = { 'Authorization' => "Bearer #{@access_token}" }
    body = { name:, description:, public: true }
    response = request(:post, url, headers:, body:)
    response.parsed_response
  end

  def add_tracks_to_playlist(playlist_id)
    url = "#{BASE_URL}/playlists/#{playlist_id}/tracks"
    headers = { 'Authorization' => "Bearer #{@access_token}" }
    body = { uris: @tracks_spotify_uris }
    response = request(:post, url, headers:, body:)
    response.parsed_response
  end
end
