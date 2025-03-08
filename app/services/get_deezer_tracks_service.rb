class GetDeezerTracksService < ApplicationService
  include Api::Request

  BASE_URL = 'https://api.deezer.com/'
  TRACKS_PER_PAGE = 25.0

  attr_reader :bpm_min, :bpm_max, :dur_min, :dur_max

  def initialize(bpm_min:, bpm_max:, dur_min:, dur_max:, count: 25)
    @bpm_min = bpm_min
    @bpm_max = bpm_max
    @dur_min = dur_min
    @dur_max = dur_max
    @count = count
    @pages_number = (count / TRACKS_PER_PAGE).ceil
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
    url = "#{BASE_URL}search?q=bpm_min:#{bpm_min}&bpm_max:#{bpm_max}&dur_min:#{dur_min}&dur_max:#{dur_max}&index=#{page_index}"
    response = request(:get, url)
    response.parsed_response['data'].each do |track|
      @tracks << { title: track['title'], album: track.dig('album', 'title'), artist: track.dig('artist', 'name') }
    end
  end
end
