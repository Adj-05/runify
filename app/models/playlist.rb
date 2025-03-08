class Playlist < ApplicationRecord
  has_many :musics
  belongs_to :training

  def create_from_args(*args)
    track_infos = GetDeezerTracksService.call(bpm_min: 120, bpm_max: 130, dur_min: 180, dur_max: 240, count: 10)
    result = CreateSpotifyPlaylistService.call(User.last, "Ma Playlist", track_infos)
    return result
  end
end
