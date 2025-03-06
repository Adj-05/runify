class PlaylistMusic < ApplicationRecord
  belongs_to :Playlist
  belongs_to :Music
end
