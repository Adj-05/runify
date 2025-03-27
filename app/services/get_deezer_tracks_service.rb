class GetDeezerTracksService < ApplicationService
  include Api::Request

  BASE_URL = 'https://api.deezer.com/'
  TRACKS_PER_PAGE = 25.0
  AVERAGE_TRACK_DURATION = 180 # Durée moyenne d'un morceau en secondes (3 min)

  attr_reader :bpm_min, :bpm_max, :dur_min, :dur_max, :count

  def initialize(bpm_min:, bpm_max:, dur_min:, dur_max:, count: 25)
    @bpm_min = bpm_min
    @bpm_max = bpm_max
    @dur_min = dur_min * 60 # Conversion en secondes
    @dur_max = dur_max * 60 # Conversion en secondes
    @count = count
    @estimated_tracks = (@dur_max / AVERAGE_TRACK_DURATION).clamp(1, count)
    @pages_number = (@estimated_tracks / TRACKS_PER_PAGE).ceil
    @tracks = []
  end

  def call
    @pages_number.times do |page|
      page_index = page * TRACKS_PER_PAGE
      get_tracks(page_index)
    end

    @tracks.first(@count)
  end

  private

  def get_tracks(page_index)
    url = "#{BASE_URL}search?q=bpm_min:#{bpm_min}&bpm_max:#{bpm_max}&index=#{page_index}"
    response = request(:get, url)

    filtered_tracks = response.parsed_response['data'].select do |track|
      track_duration = track['duration'].to_i
      track_duration.between?(@dur_min, @dur_max)
    end

    filtered_tracks.each do |track|
      @tracks << { title: track['title'], album: track.dig('album', 'title'), artist: track.dig('artist', 'name') }
    end
  end
end
