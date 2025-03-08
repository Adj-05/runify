class GetDeezerTracksService < ApplicationService
  include Api::Request

  BASE_URL = 'https://api.deezer.com/'

  attr_reader :bpm_min, :bpm_max, :dur_min, :dur_max

  def initialize(bpm_min:, bpm_max:, dur_min:, dur_max:, count: 25)
    @bpm_min = bpm_min
    @bpm_max = bpm_max
    @dur_min = dur_min
    @dur_max = dur_max
    @count = count
    @pages_number = (count / 25.0).ceil
  end

  def call
    tracks = []
    @pages_number.times do |page|
      url = "#{BASE_URL}search?q=bpm_min:#{bpm_min}&bpm_max:#{bpm_max}&dur_min:#{dur_min}&dur_max:#{dur_max}&index=#{page * 25}"
      response = request(:get, url)
      response.parsed_response['data'].each do |track|
        tracks << { title: track['title'], album: track.dig('album', 'title'), artist: track.dig('artist', 'name') }
      end
    end
    tracks.first(@count)
  end

  private


end


# track_uris = GetDeezerTracksService.call(bpm_min: 120, bpm_max: 130, dur_min: 180, dur_max: 240, count: 10)

# CreateSpotifyPlaylistService.call('Test', track_uris)
