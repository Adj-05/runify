class Playlist < ApplicationRecord
  has_many :musics, dependent: :destroy
  belongs_to :training

  accepts_nested_attributes_for :musics

  class << self
    def initialize_from_api(user:, training:, name:, bpm_min:, bpm_max:, dur_min:, dur_max:, count:, **attributes)
      track_infos = GetDeezerTracksService.call(bpm_min:, bpm_max:, dur_min:, dur_max:, count:)
      playlist = CreateSpotifyPlaylistService.call(user, name, track_infos)

      playlist_attributes = {
        training:,
        name:,
        spotify_id: playlist['id'],
        spotify_url: playlist.dig('external_urls', 'spotify'),
        spotify_uri: playlist['uri'],
        musics: build_tracks(playlist)
      }.merge(attributes)

      @playlist = Playlist.new(playlist_attributes)
    end

    def create_from_api(user:, name:, bpm_min:, bpm_max:, dur_min:, dur_max:, count:, **attributes)
      initialize_from_api(user:, name:, bpm_min:, bpm_max:, dur_min:, dur_max:, count:, **attributes).save
      @playlist
    end

    def create_from_api!(user:, name:, bpm_min:, bpm_max:, dur_min:, dur_max:, count:, **attributes)
      initialize_from_api(user:, name:, bpm_min:, bpm_max:, dur_min:, dur_max:, count:, **attributes).save!
      @playlist
    end

    private

    def build_tracks(playlist)
      playlist.dig('tracks', 'items').map do |item|
        music_attributes = {
          spotify_id: item.dig('track', 'id'),
          spotify_url: item.dig('track', 'external_urls', 'spotify'),
          spotify_uri: item.dig('track', 'uri'),
          title: item.dig('track', 'name'),
          duration: item.dig('track', 'duration_ms'),
          bpm: rand(120..130), # dummy value,
          genre: Music::MUSIC_GENRE.sample # dummy value
        }
        Music.new(music_attributes)
      end
    end
  end
end
